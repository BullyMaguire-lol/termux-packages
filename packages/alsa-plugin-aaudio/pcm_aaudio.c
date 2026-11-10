// SPDX-License-Identifier: LGPL-2.1-or-later
/*
 * ALSA PCM plugin playing through Android's AAudio, so that ALSA programs
 * (PipeWire's ALSA sink in the first place) get Android's audio output as an
 * ordinary playback device:
 *
 *   pcm.aaudio { type aaudio }
 *
 * The stream is opened with Android's own rate, format and channel count,
 * and the device offers only those: converting is the program's business
 * (PipeWire does it), so Android keeps its low-latency path.
 *
 * Android gives that path only to streams fed by a data callback, so the
 * device's buffer is the plugin's own ring: the program writes into it and
 * AAudio's callback, on Android's audio thread, takes frames out. The
 * hardware pointer is the number of frames the callback has taken. When the
 * program doesn't keep up, the callback plays silence for what is missing
 * and the pointer stops where the data ended, so playback goes on as soon as
 * new data comes (no xrun); such shortfalls are only logged.
 *
 * Option:
 *   performance_mode M  low_latency (default), none or power_saving
 */
#include <errno.h>
#include <poll.h>
#include <stdatomic.h>
#include <stdint.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <sys/timerfd.h>
#include <time.h>
#include <unistd.h>

#include <alsa/asoundlib.h>
#include <alsa/pcm_external.h>

#ifdef __ANDROID__
/* Only calls from API 26 (Android 8.0, where AAudio came) are used. */
#include <android/versioning.h>
#undef __INTRODUCED_IN
#define __INTRODUCED_IN(api_level)
#endif
#include <aaudio/AAudio.h>

#define NSEC 1000000000LL
#define RING_MAX 16384	/* most frames of buffer offered */

struct aaudio {
	snd_pcm_ioplug_t io;
	AAudioStream *stream;
	int timer;			/* poll descriptor: wakes when space is expected */
	int32_t perf_mode;		/* as asked for */
	aaudio_format_t format;		/* as Android gave */
	int32_t rate, channels, frame;	/* frame: bytes */

	/* The ring: written to by the program (under alsa-lib's lock), read
	 * by the callback. Each side only stores its own counter; both count
	 * frames since the device was prepared. */
	unsigned char *ring;
	snd_pcm_uframes_t ring_frames;
	_Atomic uint64_t written, taken;
	_Atomic uint32_t short_calls;	/* callbacks that found too little */
	_Atomic int lost;		/* Android's output went away */

	int32_t xruns;			/* AAudio's own underruns when prepared */
	snd_pcm_uframes_t boundary, avail_min;
};

static snd_pcm_format_t alsa_format(aaudio_format_t format)
{
	switch (format) {
	case AAUDIO_FORMAT_PCM_I16:
		return SND_PCM_FORMAT_S16_LE;
	case AAUDIO_FORMAT_PCM_FLOAT:
		return SND_PCM_FORMAT_FLOAT_LE;
	case AAUDIO_FORMAT_PCM_I24_PACKED:
		return SND_PCM_FORMAT_S24_3LE;
	case AAUDIO_FORMAT_PCM_I32:
		return SND_PCM_FORMAT_S32_LE;
	default:
		return SND_PCM_FORMAT_UNKNOWN;
	}
}

static const char *mode_name(int32_t mode)
{
	switch (mode) {
	case AAUDIO_PERFORMANCE_MODE_LOW_LATENCY:
		return "low latency";
	case AAUDIO_PERFORMANCE_MODE_POWER_SAVING:
		return "power saving";
	default:
		return "normal";
	}
}

static int64_t now_ns(void)
{
	struct timespec t;

	clock_gettime(CLOCK_MONOTONIC, &t);
	return t.tv_sec * NSEC + t.tv_nsec;
}

/* Android's audio thread: hands it what the ring holds, silence for the rest.
 * The formats offered are all signed, so zero bytes are silence. */
static aaudio_data_callback_result_t on_data(AAudioStream *stream, void *user, void *audio, int32_t frames)
{
	struct aaudio *a = user;
	uint64_t taken = atomic_load_explicit(&a->taken, memory_order_relaxed);
	uint64_t have = atomic_load_explicit(&a->written, memory_order_acquire) - taken;
	uint64_t n = have < (uint64_t)frames ? have : (uint64_t)frames;
	uint64_t at = taken % a->ring_frames, first = a->ring_frames - at < n ? a->ring_frames - at : n;

	(void)stream;
	memcpy(audio, a->ring + at * a->frame, first * a->frame);
	memcpy((unsigned char *)audio + first * a->frame, a->ring, (n - first) * a->frame);
	if (n < (uint64_t)frames) {
		memset((unsigned char *)audio + n * a->frame, 0, (frames - n) * a->frame);
		/* (the end of a drain runs short by design) */
		if (a->io.state == SND_PCM_STATE_RUNNING)
			atomic_fetch_add_explicit(&a->short_calls, 1, memory_order_relaxed);
	}
	atomic_store_explicit(&a->taken, taken + n, memory_order_release);
	return AAUDIO_CALLBACK_RESULT_CONTINUE;
}

/* AAudio's own thread, after the stream stopped working (e.g. a route
 * change): the next pointer query reports it, prepare reopens. */
static void on_error(AAudioStream *stream, void *user, aaudio_result_t error)
{
	struct aaudio *a = user;

	(void)stream;
	(void)error;
	atomic_store(&a->lost, 1);
}

static aaudio_result_t open_stream(struct aaudio *a, aaudio_format_t format, int32_t rate, int32_t channels)
{
	AAudioStreamBuilder *b;
	aaudio_result_t res;

	if ((res = AAudio_createStreamBuilder(&b)) != AAUDIO_OK)
		return res;
	AAudioStreamBuilder_setDirection(b, AAUDIO_DIRECTION_OUTPUT);
	AAudioStreamBuilder_setPerformanceMode(b, a->perf_mode);
	AAudioStreamBuilder_setSharingMode(b, AAUDIO_SHARING_MODE_SHARED);
	AAudioStreamBuilder_setFormat(b, format);
	AAudioStreamBuilder_setSampleRate(b, rate);
	AAudioStreamBuilder_setChannelCount(b, channels);
	AAudioStreamBuilder_setDataCallback(b, on_data, a);
	AAudioStreamBuilder_setErrorCallback(b, on_error, a);
	res = AAudioStreamBuilder_openStream(b, &a->stream);
	AAudioStreamBuilder_delete(b);
	if (res != AAUDIO_OK) {
		a->stream = NULL;
		return res;
	}
	/* Low latency: Android's own buffer of two bursts (its usual start);
	 * the ring in front of it absorbs the program's timing. */
	if (AAudioStream_getPerformanceMode(a->stream) == AAUDIO_PERFORMANCE_MODE_LOW_LATENCY)
		AAudioStream_setBufferSizeInFrames(a->stream, 2 * AAudioStream_getFramesPerBurst(a->stream));
	atomic_store(&a->lost, 0);
	return AAUDIO_OK;
}

/* Waits until the stream is in state want; 0 or -EIO. */
static int settle(struct aaudio *a, aaudio_stream_state_t want, int64_t timeout)
{
	int64_t end = now_ns() + timeout;
	aaudio_stream_state_t state = AAudioStream_getState(a->stream), next;

	while (state != want) {
		int64_t left = end - now_ns();

		if (left <= 0 || state == AAUDIO_STREAM_STATE_DISCONNECTED || state == AAUDIO_STREAM_STATE_CLOSED)
			return -EIO;
		if (AAudioStream_waitForStateChange(a->stream, state, &next, left) != AAUDIO_OK)
			next = AAudioStream_getState(a->stream);
		state = next;
	}
	return 0;
}

/* Stops playing and drops what Android has buffered; afterwards the
 * callback doesn't run. */
static int halt(struct aaudio *a)
{
	if (atomic_load(&a->lost))
		return -ENODEV;
	switch (AAudioStream_getState(a->stream)) {
	case AAUDIO_STREAM_STATE_STARTING:
	case AAUDIO_STREAM_STATE_STARTED:
		if (AAudioStream_requestPause(a->stream) != AAUDIO_OK)
			return -EIO;
		/* fall through */
	case AAUDIO_STREAM_STATE_PAUSING:
		if (settle(a, AAUDIO_STREAM_STATE_PAUSED, NSEC) < 0)
			return -EIO;
		/* fall through */
	case AAUDIO_STREAM_STATE_PAUSED:
		if (AAudioStream_requestFlush(a->stream) != AAUDIO_OK)
			return -EIO;
		/* fall through */
	case AAUDIO_STREAM_STATE_FLUSHING:
		return settle(a, AAUDIO_STREAM_STATE_FLUSHED, NSEC);
	case AAUDIO_STREAM_STATE_STOPPING:
		return settle(a, AAUDIO_STREAM_STATE_STOPPED, NSEC);
	case AAUDIO_STREAM_STATE_DISCONNECTED:
		return -ENODEV;
	default:
		return 0;
	}
}

static void report(struct aaudio *a)
{
	uint32_t short_calls = atomic_exchange(&a->short_calls, 0);
	int32_t xruns = AAudioStream_getXRunCount(a->stream);

	if (short_calls)
		fprintf(stderr, "aaudio: the program fell behind %u times (silence played)\n", short_calls);
	if (xruns > a->xruns)
		fprintf(stderr, "aaudio: Android's buffer ran dry %d times\n", xruns - a->xruns);
	a->xruns = xruns;
}

static int aa_hw_params(snd_pcm_ioplug_t *io, snd_pcm_hw_params_t *params)
{
	struct aaudio *a = io->private_data;
	unsigned char *ring;

	(void)params;
	/* The stream isn't started here, so the callback doesn't run. */
	if (!(ring = realloc(a->ring, io->buffer_size * a->frame)))
		return -ENOMEM;
	a->ring = ring;
	a->ring_frames = io->buffer_size;
	fprintf(stderr, "aaudio: %d Hz %s, %d channels, burst %d, Android's buffer %d of %d frames, %s%s; "
		"buffer %lu (period %lu)\n",
		a->rate, snd_pcm_format_name(alsa_format(a->format)), a->channels,
		AAudioStream_getFramesPerBurst(a->stream), AAudioStream_getBufferSizeInFrames(a->stream),
		AAudioStream_getBufferCapacityInFrames(a->stream), mode_name(AAudioStream_getPerformanceMode(a->stream)),
		a->perf_mode != AAudioStream_getPerformanceMode(a->stream) ? " (not granted)" : "",
		io->buffer_size, io->period_size);
	return 0;
}

static int aa_sw_params(snd_pcm_ioplug_t *io, snd_pcm_sw_params_t *params)
{
	struct aaudio *a = io->private_data;

	snd_pcm_sw_params_get_boundary(params, &a->boundary);
	snd_pcm_sw_params_get_avail_min(params, &a->avail_min);
	return 0;
}

static int aa_prepare(snd_pcm_ioplug_t *io)
{
	struct aaudio *a = io->private_data;
	int res = halt(a);

	if (res == -ENODEV) {
		/* Android's output went away (e.g. a route change): a new stream
		 * with this device's settings, Android converting if it must. */
		AAudioStream_close(a->stream);
		if (open_stream(a, a->format, a->rate, a->channels) != AAUDIO_OK) {
			SNDERR("aaudio: cannot reopen the stream");
			return -ENODEV;
		}
		fprintf(stderr, "aaudio: output disconnected, stream reopened\n");
		a->xruns = 0;
		res = 0;
	}
	if (res < 0)
		return res;
	report(a);
	atomic_store(&a->written, 0);
	atomic_store(&a->taken, 0);
	return 0;
}

static int aa_start(snd_pcm_ioplug_t *io)
{
	struct aaudio *a = io->private_data;
	aaudio_result_t res = AAudioStream_requestStart(a->stream);

	if (res == AAUDIO_OK)
		return 0;
	return res == AAUDIO_ERROR_DISCONNECTED ? -ENODEV : -EIO;
}

static int aa_stop(snd_pcm_ioplug_t *io)
{
	struct aaudio *a = io->private_data;

	halt(a);
	report(a);
	return 0;
}

static int aa_pause(snd_pcm_ioplug_t *io, int enable)
{
	struct aaudio *a = io->private_data;
	aaudio_result_t res = enable ? AAudioStream_requestPause(a->stream) : AAudioStream_requestStart(a->stream);

	return res == AAUDIO_OK ? 0 : -EIO;
}

/* Plays out what is buffered: the ring empties into Android, then AAudio's
 * stop plays out Android's own buffer. */
static int aa_drain(snd_pcm_ioplug_t *io)
{
	struct aaudio *a = io->private_data;
	aaudio_stream_state_t state = AAudioStream_getState(a->stream);
	uint64_t left = atomic_load(&a->written) - atomic_load(&a->taken);
	int64_t end = now_ns() + (int64_t)(left * NSEC / a->rate) + NSEC;

	if (state != AAUDIO_STREAM_STATE_STARTING && state != AAUDIO_STREAM_STATE_STARTED &&
	    AAudioStream_requestStart(a->stream) != AAUDIO_OK)
		return -EIO;
	while ((left = atomic_load(&a->written) - atomic_load(&a->taken)) > 0 && !atomic_load(&a->lost) &&
	       now_ns() < end) {
		int64_t ns = (int64_t)(left * NSEC / a->rate);
		struct timespec t = { .tv_sec = ns / NSEC, .tv_nsec = ns % NSEC };

		if (ns < 1000000)
			t.tv_nsec = 1000000;
		nanosleep(&t, NULL);
	}
	if (AAudioStream_requestStop(a->stream) != AAUDIO_OK)
		return -EIO;
	settle(a, AAUDIO_STREAM_STATE_STOPPED, NSEC);
	return 0;
}

static snd_pcm_sframes_t aa_pointer(snd_pcm_ioplug_t *io)
{
	struct aaudio *a = io->private_data;

	if (atomic_load(&a->lost))
		return -EPIPE;
	return atomic_load_explicit(&a->taken, memory_order_acquire) % (a->boundary ? a->boundary : io->buffer_size);
}

static snd_pcm_sframes_t aa_transfer(snd_pcm_ioplug_t *io, const snd_pcm_channel_area_t *areas,
				     snd_pcm_uframes_t offset, snd_pcm_uframes_t size)
{
	struct aaudio *a = io->private_data;
	const unsigned char *data = (const unsigned char *)areas->addr + (areas->first + areas->step * offset) / 8;
	uint64_t written = atomic_load_explicit(&a->written, memory_order_relaxed);
	uint64_t space = a->ring_frames - (written - atomic_load_explicit(&a->taken, memory_order_acquire));
	uint64_t n = size < space ? size : space;
	uint64_t at = written % a->ring_frames, first = a->ring_frames - at < n ? a->ring_frames - at : n;

	if (atomic_load(&a->lost))
		return -EPIPE;
	memcpy(a->ring + at * a->frame, data, first * a->frame);
	memcpy(a->ring, data + first * a->frame, (n - first) * a->frame);
	atomic_store_explicit(&a->written, written + n, memory_order_release);
	return n;
}

/* Frames until a frame written now is heard: what the ring holds, plus what
 * Android holds, from the frame AAudio says was presented, and when. */
static int aa_delay(snd_pcm_ioplug_t *io, snd_pcm_sframes_t *delayp)
{
	struct aaudio *a = io->private_data;
	int64_t ring = atomic_load(&a->written) - atomic_load(&a->taken);
	int64_t handed = AAudioStream_getFramesWritten(a->stream), heard, when, android;

	if ((io->state == SND_PCM_STATE_RUNNING || io->state == SND_PCM_STATE_DRAINING) &&
	    AAudioStream_getTimestamp(a->stream, CLOCK_MONOTONIC, &heard, &when) == AAUDIO_OK)
		android = handed - heard - (now_ns() - when) * a->rate / NSEC;
	else
		android = handed - AAudioStream_getFramesRead(a->stream);
	*delayp = ring + (android > 0 ? android : 0);
	return 0;
}

/* Arms the poll descriptor for when avail_min frames are expected free. */
static void arm(struct aaudio *a)
{
	snd_pcm_sframes_t avail = snd_pcm_avail_update(a->io.pcm);
	struct itimerspec when = { 0 };

	if (avail < 0 || (snd_pcm_uframes_t)avail >= a->avail_min) {
		when.it_value.tv_nsec = 1;	/* now */
	} else if (a->io.state == SND_PCM_STATE_RUNNING) {
		int64_t ns = (int64_t)(a->avail_min - avail) * NSEC / a->rate;

		if (ns < 1000000)
			ns = 1000000;
		when.it_value.tv_sec = ns / NSEC;
		when.it_value.tv_nsec = ns % NSEC;
	}	/* else nothing frees space until the program starts the device */
	timerfd_settime(a->timer, 0, &when, NULL);
}

static int aa_poll_descriptors(snd_pcm_ioplug_t *io, struct pollfd *pfd, unsigned int space)
{
	struct aaudio *a = io->private_data;

	if (space < 1)
		return 0;
	arm(a);
	pfd->fd = a->timer;
	pfd->events = POLLIN;
	pfd->revents = 0;
	return 1;
}

static int aa_poll_revents(snd_pcm_ioplug_t *io, struct pollfd *pfd, unsigned int nfds, unsigned short *revents)
{
	struct aaudio *a = io->private_data;
	snd_pcm_sframes_t avail;
	uint64_t expired;

	(void)pfd;
	(void)nfds;
	if (read(a->timer, &expired, sizeof(expired)) < 0 && errno != EAGAIN)
		return -errno;
	avail = snd_pcm_avail_update(io->pcm);
	if (avail < 0) {
		*revents = POLLOUT | POLLERR;
	} else if ((snd_pcm_uframes_t)avail >= a->avail_min) {
		*revents = POLLOUT;
	} else {
		*revents = 0;
		arm(a);
	}
	return 0;
}

static int aa_close(snd_pcm_ioplug_t *io)
{
	struct aaudio *a = io->private_data;

	if (a->stream)
		AAudioStream_close(a->stream);	/* waits for a running callback */
	if (a->timer >= 0)
		close(a->timer);
	free(a->ring);
	free(a);
	return 0;
}

static const snd_pcm_ioplug_callback_t aa_callbacks = {
	.start = aa_start,
	.stop = aa_stop,
	.pointer = aa_pointer,
	.transfer = aa_transfer,
	.close = aa_close,
	.hw_params = aa_hw_params,
	.sw_params = aa_sw_params,
	.prepare = aa_prepare,
	.drain = aa_drain,
	.pause = aa_pause,
	.poll_descriptors = aa_poll_descriptors,
	.poll_revents = aa_poll_revents,
	.delay = aa_delay,
};

static int constrain(struct aaudio *a)
{
	static const unsigned int access[] = { SND_PCM_ACCESS_MMAP_INTERLEAVED, SND_PCM_ACCESS_RW_INTERLEAVED };
	unsigned int format = alsa_format(a->format);
	unsigned int burst = AAudioStream_getFramesPerBurst(a->stream);
	int res;

	if (burst == 0 || burst > RING_MAX / 2) {
		SNDERR("aaudio: unusable burst of %u frames", burst);
		return -EIO;
	}
	if ((res = snd_pcm_ioplug_set_param_list(&a->io, SND_PCM_IOPLUG_HW_ACCESS, 2, access)) < 0 ||
	    (res = snd_pcm_ioplug_set_param_list(&a->io, SND_PCM_IOPLUG_HW_FORMAT, 1, &format)) < 0 ||
	    (res = snd_pcm_ioplug_set_param_minmax(&a->io, SND_PCM_IOPLUG_HW_CHANNELS, a->channels, a->channels)) < 0 ||
	    (res = snd_pcm_ioplug_set_param_minmax(&a->io, SND_PCM_IOPLUG_HW_RATE, a->rate, a->rate)) < 0 ||
	    (res = snd_pcm_ioplug_set_param_minmax(&a->io, SND_PCM_IOPLUG_HW_PERIOD_BYTES,
						   burst * a->frame, RING_MAX / 2 * a->frame)) < 0 ||
	    (res = snd_pcm_ioplug_set_param_minmax(&a->io, SND_PCM_IOPLUG_HW_BUFFER_BYTES,
						   2 * burst * a->frame, RING_MAX * a->frame)) < 0 ||
	    (res = snd_pcm_ioplug_set_param_minmax(&a->io, SND_PCM_IOPLUG_HW_PERIODS, 2, 1024)) < 0)
		return res;
	return 0;
}

SND_PCM_PLUGIN_DEFINE_FUNC(aaudio)
{
	snd_config_iterator_t i, next;
	const char *perf = "low_latency";
	struct aaudio *a;
	aaudio_result_t ares;
	int res;

	(void)root;
	snd_config_for_each(i, next, conf) {
		snd_config_t *n = snd_config_iterator_entry(i);
		const char *id;

		if (snd_config_get_id(n, &id) < 0)
			continue;
		if (!strcmp(id, "comment") || !strcmp(id, "type") || !strcmp(id, "hint"))
			continue;
		if (!strcmp(id, "performance_mode")) {
			if (snd_config_get_string(n, &perf) < 0) {
				SNDERR("aaudio: invalid performance_mode");
				return -EINVAL;
			}
			continue;
		}
		SNDERR("aaudio: unknown field %s", id);
		return -EINVAL;
	}
	if (stream != SND_PCM_STREAM_PLAYBACK) {
		SNDERR("aaudio: playback only");
		return -EINVAL;
	}

	if (!(a = calloc(1, sizeof(*a))))
		return -ENOMEM;
	if (!strcmp(perf, "low_latency")) {
		a->perf_mode = AAUDIO_PERFORMANCE_MODE_LOW_LATENCY;
	} else if (!strcmp(perf, "none")) {
		a->perf_mode = AAUDIO_PERFORMANCE_MODE_NONE;
	} else if (!strcmp(perf, "power_saving")) {
		a->perf_mode = AAUDIO_PERFORMANCE_MODE_POWER_SAVING;
	} else {
		SNDERR("aaudio: performance_mode must be low_latency, none or power_saving");
		free(a);
		return -EINVAL;
	}
	if ((a->timer = timerfd_create(CLOCK_MONOTONIC, TFD_NONBLOCK | TFD_CLOEXEC)) < 0) {
		res = -errno;
		free(a);
		return res;
	}
	/* Android's own settings: whatever it plays without converting. */
	if ((ares = open_stream(a, AAUDIO_FORMAT_UNSPECIFIED, AAUDIO_UNSPECIFIED, AAUDIO_UNSPECIFIED)) != AAUDIO_OK) {
		SNDERR("aaudio: cannot open a stream: %s", AAudio_convertResultToText(ares));
		close(a->timer);
		free(a);
		return -ENODEV;
	}
	a->format = AAudioStream_getFormat(a->stream);
	a->rate = AAudioStream_getSampleRate(a->stream);
	a->channels = AAudioStream_getChannelCount(a->stream);
	if (alsa_format(a->format) == SND_PCM_FORMAT_UNKNOWN || a->rate <= 0 || a->channels <= 0) {
		SNDERR("aaudio: unsupported stream: format %d, %d Hz, %d channels", a->format, a->rate, a->channels);
		AAudioStream_close(a->stream);
		close(a->timer);
		free(a);
		return -ENODEV;
	}
	a->frame = snd_pcm_format_physical_width(alsa_format(a->format)) / 8 * a->channels;

	a->io.version = SND_PCM_IOPLUG_VERSION;
	a->io.name = "AAudio";
	a->io.flags = SND_PCM_IOPLUG_FLAG_BOUNDARY_WA | SND_PCM_IOPLUG_FLAG_MONOTONIC;
	a->io.poll_fd = a->timer;
	a->io.poll_events = POLLIN;
	a->io.callback = &aa_callbacks;
	a->io.private_data = a;
	if ((res = snd_pcm_ioplug_create(&a->io, name, stream, mode)) < 0) {
		AAudioStream_close(a->stream);
		close(a->timer);
		free(a);
		return res;
	}
	if ((res = constrain(a)) < 0) {
		snd_pcm_ioplug_delete(&a->io);	/* calls aa_close */
		return res;
	}
	*pcmp = a->io.pcm;
	return 0;
}

SND_PCM_PLUGIN_SYMBOL(aaudio);

TERMUX_PKG_HOMEPAGE=https://developer.android.com/ndk/guides/audio/aaudio/aaudio
TERMUX_PKG_DESCRIPTION="ALSA plugin playing through Android's AAudio, with a PipeWire sink using it"
TERMUX_PKG_LICENSE="LGPL-2.1"
TERMUX_PKG_MAINTAINER="@termux"
TERMUX_PKG_VERSION=0.1.0
TERMUX_PKG_SKIP_SRC_EXTRACT=true
TERMUX_PKG_BUILD_IN_SRC=true
TERMUX_PKG_DEPENDS="alsa-lib"

termux_step_make() {
	# AAudio came with Android 8.0 (API 26), newer than what Termux builds for.
	local _libdir="$TERMUX_PKG_TMPDIR/libaaudio"
	mkdir -p "$_libdir"
	cp "$TERMUX_STANDALONE_TOOLCHAIN/sysroot/usr/lib/$TERMUX_HOST_PLATFORM/26/libaaudio.so" "$_libdir"
	$CC $CFLAGS $CPPFLAGS -fPIC -DPIC -shared -o libasound_module_pcm_aaudio.so \
		"$TERMUX_PKG_BUILDER_DIR/pcm_aaudio.c" $LDFLAGS -L"$_libdir" -laaudio -lasound
}

termux_step_make_install() {
	install -Dm600 libasound_module_pcm_aaudio.so "$TERMUX_PREFIX/lib/alsa-lib/libasound_module_pcm_aaudio.so"
	# pcm.aaudio, read by alsa-lib from etc/alsa/conf.d (as alsa-plugins does it)
	install -Dm600 "$TERMUX_PKG_BUILDER_DIR/alsa-aaudio.conf" "$TERMUX_PREFIX/share/alsa/alsa.conf.d/50-aaudio.conf"
	mkdir -p "$TERMUX_PREFIX/etc/alsa/conf.d"
	ln -sf "$TERMUX_PREFIX/share/alsa/alsa.conf.d/50-aaudio.conf" "$TERMUX_PREFIX/etc/alsa/conf.d/50-aaudio.conf"
	# PipeWire's sink on it (needs pipewire built with its ALSA plugin; skipped otherwise)
	install -Dm600 "$TERMUX_PKG_BUILDER_DIR/pipewire-aaudio.conf" "$TERMUX_PREFIX/share/pipewire/pipewire.conf.d/50-aaudio.conf"
}

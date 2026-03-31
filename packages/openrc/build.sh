TERMUX_PKG_HOMEPAGE="https://github.com/OpenRC/openrc"
TERMUX_PKG_DESCRIPTION="OpenRC manages services, startup and shutdown of a system"
TERMUX_PKG_LICENSE="BSD"
TERMUX_PKG_MAINTAINER="@termux"
TERMUX_PKG_VERSION="0.63"
TERMUX_PKG_SRCURL="https://github.com/OpenRC/openrc/archive/refs/tags/${TERMUX_PKG_VERSION}.tar.gz"
TERMUX_PKG_SHA256="1b661016bd8cd4189be83b441dd7062c967b641fdc00f741e359e22d06857df8"
TERMUX_PKG_AUTO_UPDATE=true
TERMUX_PKG_UPDATE_TAG_TYPE="newest-tag"
TERMUX_PKG_DEPENDS="bash-completion, libandroid-spawn, libc++, libcap, zsh-completions"
TERMUX_PKG_EXTRA_CONFIGURE_ARGS="
-Daudit=disabled
-Dselinux=disabled
-Dpam=false
-Dnewnet=false
-Dsysvinit=false
-Dbash-completions=true
-Dzsh-completions=true
-Dpkgconfig=true
-Dbranding=""
-Dlocal_prefix=$TERMUX_PREFIX
-Dpkg_prefix=$TERMUX_PREFIX
-Dshell=$TERMUX_PREFIX/bin/sh
-Dsbindir=$TERMUX_PREFIX/bin
-Dbindir=$TERMUX_PREFIX/bin
"

termux_step_pre_configure() {
	LDFLAGS+=" -lcap  -landroid-spawn"
}

termux_step_post_massage() {
	# OpenRC requires /var/run/openrc/softlevel to exist if it was not booted.
	# As suggested by OpenRC itself, create this file so services can run.
	mkdir -p $TERMUX_PKG_MASSAGEDIR/$TERMUX_PREFIX/var/run/openrc
	touch $TERMUX_PKG_MASSAGEDIR/$TERMUX_PREFIX/var/run/openrc/softlevel
}

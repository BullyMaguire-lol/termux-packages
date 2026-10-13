TERMUX_PKG_HOMEPAGE="https://gitlab.freedesktop.org/libinput/libinput"
TERMUX_PKG_DESCRIPTION="Input device management and event handling library"
TERMUX_PKG_LICENSE="MIT"
TERMUX_PKG_MAINTAINER="@termux"
TERMUX_PKG_VERSION="1.32.0"
TERMUX_PKG_SRCURL="https://gitlab.freedesktop.org/libinput/libinput/-/archive/${TERMUX_PKG_VERSION}/libinput-${TERMUX_PKG_VERSION}.tar.gz"
TERMUX_PKG_SHA256="7dd6c1ca964c86eb6810ccd6639cda634e68bdca43bf3afec39e94e942fac8d4"
TERMUX_PKG_AUTO_UPDATE=true
TERMUX_PKG_DEPENDS="libc++, libevdev, lua52, libudev-zero, mtdev"
TERMUX_PKG_BUILD_DEPENDS="check, gtk4, libudev-zero, libwayland, libwayland-protocols, libx11, python"
TERMUX_PKG_EXTRA_CONFIGURE_ARGS="
-Dtests=false
-Ddocumentation=false
-Ddebug-gui=false
-Dlibwacom=false
-Dmtdev=false
-Dinstall-tests=false
-Dlua-plugins=disabled
-Dautoload-plugins=false
"

termux_step_pre_configure() {
	CPPFLAGS+=" -Dindex=strchr -Drindex=strrchr"
}

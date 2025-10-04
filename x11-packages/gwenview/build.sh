TERMUX_PKG_HOMEPAGE="https://apps.kde.org/gwenview"
TERMUX_PKG_DESCRIPTION="A fast and easy to use image viewer"
TERMUX_PKG_LICENSE="GPL-2.0-or-later"
TERMUX_PKG_MAINTAINER="@termux"
TERMUX_PKG_VERSION="25.08.1"
TERMUX_PKG_SRCURL="https://download.kde.org/stable/release-service/${TERMUX_PKG_VERSION}/src/gwenview-${TERMUX_PKG_VERSION}.tar.xz"
TERMUX_PKG_SHA256=4d92eef8fd543930cff6810062bc1d9ff103394247516bfef1edcd1bd67ad67c
TERMUX_PKG_AUTO_UPDATE=true
TERMUX_PKG_DEPENDS="qt6-qtbase, qt6-qtsvg, qt6-qtmultimedia, kf6-kio, kf6-kitemmodels, kf6-ki18n, kf6-kparts, kf6-kwindowsystem, kf6-kiconthemes, kf6-knotifications, kf6-kguiaddons, kf6-kwidgetsaddons, kf6-kcrash, exiv2, kimageannotator"
TERMUX_PKG_BUILD_DEPENDS="extra-cmake-modules"
TERMUX_PKG_EXTRA_CONFIGURE_ARGS="
-DCMAKE_SYSTEM_NAME=Linux
-DBUILD_DOC=OFF
-DKDE_INSTALL_QMLDIR=lib/qt6/qml
-DKDE_INSTALL_QTPLUGINDIR=lib/qt6/plugins
-DGWENVIEW_NO_WAYLAND_GESTURES=ON
"

termux_step_pre_configure() {
	if [[ "$TERMUX_ON_DEVICE_BUILD" == "false" ]]; then
		TERMUX_PKG_EXTRA_CONFIGURE_ARGS+=" -DKF6_HOST_TOOLING=$TERMUX_PREFIX/opt/kf6/cross/lib/cmake/"
	fi
}

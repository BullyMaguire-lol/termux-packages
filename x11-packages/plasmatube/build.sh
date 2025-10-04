TERMUX_PKG_HOMEPAGE="https://apps.kde.org/plasmatube"
TERMUX_PKG_DESCRIPTION="Kirigami YouTube video player based on QtMultimedia and youtube-dl"
TERMUX_PKG_LICENSE="GPL-2.0-or-later"
TERMUX_PKG_MAINTAINER="@termux"
TERMUX_PKG_VERSION="25.08.1"
TERMUX_PKG_SRCURL="https://download.kde.org/stable/release-service/${TERMUX_PKG_VERSION}/src/plasmatube-${TERMUX_PKG_VERSION}.tar.xz"
TERMUX_PKG_SHA256=daac61ce78a71096c89971daa3ee4b168661b0abc5c2e6d892c3003671000d2f
TERMUX_PKG_AUTO_UPDATE=true
TERMUX_PKG_DEPENDS="qt6-qtbase, qt6-qttools, qt6-qtsvg, kf6-kcoreaddons, kf6-kconfig, kf6-kirigami, kf6-ki18n, kf6-kirigami-addons, kf6-kdbusaddons, kf6-kwindowsystem, qtkeychain, mpvqt"
TERMUX_PKG_BUILD_DEPENDS="extra-cmake-modules"
TERMUX_PKG_EXTRA_CONFIGURE_ARGS="
-DCMAKE_SYSTEM_NAME=Linux
-DBUILD_DOC=OFF
-DKDE_INSTALL_QMLDIR=lib/qt6/qml
-DKDE_INSTALL_QTPLUGINDIR=lib/qt6/plugins
"

termux_step_pre_configure() {
	if [[ "$TERMUX_ON_DEVICE_BUILD" == "false" ]]; then
		TERMUX_PKG_EXTRA_CONFIGURE_ARGS+=" -DKF6_HOST_TOOLING=$TERMUX_PREFIX/opt/kf6/cross/lib/cmake/"
	fi
}

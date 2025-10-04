TERMUX_PKG_HOMEPAGE="https://apps.kde.org/kate"
TERMUX_PKG_DESCRIPTION="Advanced text editor"
TERMUX_PKG_LICENSE="GPL-2.0-or-later"
TERMUX_PKG_MAINTAINER="@termux"
TERMUX_PKG_VERSION="25.08.1"
TERMUX_PKG_SRCURL="https://download.kde.org/stable/release-service/${TERMUX_PKG_VERSION}/src/dolphin-${TERMUX_PKG_VERSION}.tar.xz"
TERMUX_PKG_SHA256=08b051c0696724fd8d620ffa6afc1bff080592a356b79ce2bb50bc841071eacd
TERMUX_PKG_AUTO_UPDATE=true
# TERMUX_PKG_DEPENDS="qt6-qtbase, kf6-ki18n, kf6-kcoreaddons, kf6-kguiaddons, kf6-kcrash, kf6-kiconthemes, kf6-ktexteditor"
TERMUX_PKG_DEPENDS="qt6-qtbase, kf6-kcmutils, kf6-knewstuff, kf6-kcoreaddons, kf6-ki18n, kf6-kdbusaddons, kf6-kbookmarks, kf6-kconfig, kf6-kio, kf6-kparts, kf6-solid, kf6-kiconthemes, kf6-kcompletion, kf6-ktextwidgets, kf6-knotifications, kf6-kcrash, kf6-kwindowsystem, kf6-kcodecs, kf6-kguiaddons, kf6-kcolorscheme, kf6-kfilemetadata"
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

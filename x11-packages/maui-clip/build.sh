TERMUX_PKG_HOMEPAGE="https://invent.kde.org/maui/maui-clip"
TERMUX_PKG_DESCRIPTION="Video player and video collection manager"
TERMUX_PKG_LICENSE="LGPL-3.0-only"
TERMUX_PKG_MAINTAINER="@termux"
TERMUX_PKG_VERSION="4.0.2"
TERMUX_PKG_SRCURL="https://download.kde.org/stable/maui/clip/${TERMUX_PKG_VERSION}/maui-clip-${TERMUX_PKG_VERSION}.tar.xz"
TERMUX_PKG_SHA256="e1aec9766dcb4a265e57a5b6140f930222da2eb7740019a4d4a2372b920da182"
TERMUX_PKG_AUTO_UPDATE=true
TERMUX_PKG_DEPENDS="ffmpeg, kf6-kcoreaddons, kf6-ki18n, libc++, mauikit, mauikit-filebrowsing, qt6-qtbase, qt6-qtdeclarative, qt6-qtmultimedia, taglib"
TERMUX_PKG_BUILD_DEPENDS="extra-cmake-modules"
TERMUX_PKG_EXTRA_CONFIGURE_ARGS="
-DCMAKE_SYSTEM_NAME=Linux
-DKDE_INSTALL_QMLDIR=lib/qt6/qml
-DKDE_INSTALL_QTPLUGINDIR=lib/qt6/plugins
"

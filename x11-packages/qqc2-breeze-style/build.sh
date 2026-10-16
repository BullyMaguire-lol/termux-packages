TERMUX_PKG_HOMEPAGE="https://invent.kde.org/plasma/qqc2-breeze-style"
TERMUX_PKG_DESCRIPTION="Applications useful for Plasma development"
TERMUX_PKG_LICENSE="LGPL-2.0-or-later"
TERMUX_PKG_MAINTAINER="@termux"
TERMUX_PKG_VERSION="6.8.2"
TERMUX_PKG_SRCURL="https://download.kde.org/stable/plasma/${TERMUX_PKG_VERSION}/qqc2-breeze-style-${TERMUX_PKG_VERSION}.tar.xz"
TERMUX_PKG_SHA256=f27528b3da92abefe3eb7f302c24707279871444996c9f1868c96fb0d040e6a0
TERMUX_PKG_AUTO_UPDATE=true
TERMUX_PKG_DEPENDS="kf6-kcolorscheme, kf6-kconfig, kf6-kguiaddons, kf6-kiconthemes, kf6-kirigami, libc++, qt6-qtbase, qt6-qtdeclarative"
TERMUX_PKG_BUILD_DEPENDS="extra-cmake-modules"
TERMUX_PKG_EXTRA_CONFIGURE_ARGS="
-DCMAKE_SYSTEM_NAME=Linux
-DKDE_INSTALL_QMLDIR=lib/qt6/qml
-DKDE_INSTALL_QTPLUGINDIR=lib/qt6/plugins
"

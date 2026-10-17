TERMUX_PKG_HOMEPAGE="https://invent.kde.org/plasma/union"
TERMUX_PKG_DESCRIPTION="A style engine for Qt and Plasma"
TERMUX_PKG_LICENSE="LGPL-2.1, LGPL-3.0"
TERMUX_PKG_MAINTAINER="@termux"
TERMUX_PKG_VERSION="6.8.0"
TERMUX_PKG_SRCURL="https://download.kde.org/stable/plasma/${TERMUX_PKG_VERSION}/union-${TERMUX_PKG_VERSION}.tar.xz"
TERMUX_PKG_SHA256="d7340ffe4e269c6ee676acc6c93b928932b06ee2654ae3e7b904b699fb46a46c"
TERMUX_PKG_AUTO_UPDATE=true
TERMUX_PKG_DEPENDS="cxx-rust-cssparser, kf6-kcolorscheme, kf6-kconfig, kf6-kcoreaddons, kf6-kguiaddons, kf6-kiconthemes, kf6-kirigami, libc++, qt6-qtbase, qt6-qtdeclarative, zlib"
TERMUX_PKG_BUILD_DEPENDS="extra-cmake-modules, qt6-qtshadertools"
TERMUX_PKG_RECOMMENDS="breeze"
TERMUX_PKG_EXTRA_CONFIGURE_ARGS="
-DCMAKE_SYSTEM_NAME=Linux
-DKDE_INSTALL_QMLDIR=lib/qt6/qml
-DKDE_INSTALL_QTPLUGINDIR=lib/qt6/plugins
"

TERMUX_PKG_HOMEPAGE="https://invent.kde.org/maui/mauikit-imagetools"
TERMUX_PKG_DESCRIPTION="MauiKit Image Tools Components"
TERMUX_PKG_LICENSE="LGPL-3.0-only"
TERMUX_PKG_MAINTAINER="@termux"
TERMUX_PKG_VERSION="4.0.2"
TERMUX_PKG_SRCURL="https://download.kde.org/stable/maui/mauikit-imagetools/${TERMUX_PKG_VERSION}/mauikit-imagetools-${TERMUX_PKG_VERSION}.tar.xz"
TERMUX_PKG_SHA256="ed636a9566c1fc0424cb59fa048d2c044d1138336dbabf08d227625f84e6a9f4"
TERMUX_PKG_AUTO_UPDATE=true
TERMUX_PKG_DEPENDS="kf6-kcoreaddons, kf6-ki18n, kquickimageeditor, leptonica, libc++, libkexiv2, mauikit, mauikit-filebrowsing, opencv, qt6-qtbase, qt6-qtdeclarative, qt6-qtlocation, qt6-qtpositioning, tesseract"
TERMUX_PKG_BUILD_DEPENDS="extra-cmake-modules"
TERMUX_PKG_EXTRA_CONFIGURE_ARGS="
-DCMAKE_SYSTEM_NAME=Linux
-DKDE_INSTALL_QMLDIR=lib/qt6/qml
-DKDE_INSTALL_QTPLUGINDIR=lib/qt6/plugins
"

termux_step_pre_configure() {
	CXXFLAGS+=" -I$TERMUX_PREFIX/include/opencv4"
}

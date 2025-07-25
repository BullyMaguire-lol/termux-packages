TERMUX_PKG_HOMEPAGE="https://invent.kde.org/frameworks/prison"
TERMUX_PKG_DESCRIPTION="A barcode API to produce QRCode barcodes and DataMatrix barcodes"
TERMUX_PKG_LICENSE="CC0-1.0"
TERMUX_PKG_MAINTAINER="@termux"
TERMUX_PKG_VERSION="6.16.0"
_KF6_MINOR_VERSION="${TERMUX_PKG_VERSION%.*}"
TERMUX_PKG_SRCURL="https://download.kde.org/stable/frameworks/${_KF6_MINOR_VERSION}/prison-${TERMUX_PKG_VERSION}.tar.xz"
TERMUX_PKG_SHA256="382b2b9e3a0055c34b60290352b8566a8bff75ca8735b9534a076383d6e4e510"
TERMUX_PKG_AUTO_UPDATE=true
TERMUX_PKG_DEPENDS="libc++, qt6-qtbase, qt6-qtmultimedia, libqrencode, libdmtx, libzxing-cpp"
TERMUX_PKG_BUILD_DEPENDS="extra-cmake-modules, qt6-qttools, qt6-qtdeclarative"
TERMUX_PKG_EXTRA_CONFIGURE_ARGS="
-DCMAKE_SYSTEM_NAME=Linux
-DKDE_INSTALL_QMLDIR=lib/qt6/qml
-DKDE_INSTALL_QTPLUGINDIR=lib/qt6/plugins
"

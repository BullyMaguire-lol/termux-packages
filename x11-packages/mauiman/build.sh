TERMUX_PKG_HOMEPAGE="https://invent.kde.org/maui/mauiman"
TERMUX_PKG_DESCRIPTION="Maui Manager Library. Server and public library API."
TERMUX_PKG_LICENSE="LGPL-3.0-only"
TERMUX_PKG_MAINTAINER="@termux"
TERMUX_PKG_VERSION="4.0.2"
TERMUX_PKG_SRCURL="https://download.kde.org/stable/maui/mauiman/${TERMUX_PKG_VERSION}/mauiman-${TERMUX_PKG_VERSION}.tar.xz"
TERMUX_PKG_SHA256="81f9f25fbc959040b7efcca1d9d127c5894c6a6baf2ffe53ccba42d682258f00"
TERMUX_PKG_AUTO_UPDATE=true
TERMUX_PKG_DEPENDS="libc++, qt6-qtbase"
TERMUX_PKG_BUILD_DEPENDS="extra-cmake-modules"
TERMUX_PKG_EXTRA_CONFIGURE_ARGS="
-DCMAKE_SYSTEM_NAME=Linux
-DKDE_INSTALL_QMLDIR=lib/qt6/qml
-DKDE_INSTALL_QTPLUGINDIR=lib/qt6/plugins
"

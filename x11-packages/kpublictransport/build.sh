TERMUX_PKG_HOMEPAGE="https://invent.kde.org/libraries/kpublictransport"
TERMUX_PKG_DESCRIPTION="Library to assist with accessing public transport timetables and other data"
TERMUX_PKG_LICENSE="LGPL-2.0-or-later"
TERMUX_PKG_MAINTAINER="@termux"
TERMUX_PKG_VERSION="25.12.3"
TERMUX_PKG_SRCURL="https://download.kde.org/stable/release-service/${TERMUX_PKG_VERSION}/src/kpublictransport-${TERMUX_PKG_VERSION}.tar.xz"
TERMUX_PKG_SHA256="5817a6d41d485322e79aef8dcab52b2dd01b86f5df2327a9104809addb0c44e7"
TERMUX_PKG_AUTO_UPDATE=true
TERMUX_PKG_DEPENDS="kf6-ki18n, libc++, qt6-positioning, qt6-qtbase, qt6-qtdeclarative, qt6-qtlocation, zlib"
TERMUX_PKG_BUILD_DEPENDS="extra-cmake-modules, kirigami-addons, protobuf"
TERMUX_PKG_EXTRA_CONFIGURE_ARGS="
-DCMAKE_SYSTEM_NAME=Linux
-DKDE_INSTALL_QMLDIR=lib/qt6/qml
-DKDE_INSTALL_QTPLUGINDIR=lib/qt6/plugins
"

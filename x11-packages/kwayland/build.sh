TERMUX_PKG_HOMEPAGE="https://invent.kde.org/plasma/kwayland"
TERMUX_PKG_DESCRIPTION="Qt-style Client and Server library wrapper for Wayland libraries"
TERMUX_PKG_LICENSE="LGPL-2.1-or-later"
TERMUX_PKG_MAINTAINER="@termux"
TERMUX_PKG_VERSION="6.4.3"
TERMUX_PKG_SRCURL="https://download.kde.org/stable/plasma/${TERMUX_PKG_VERSION}/kwayland-${TERMUX_PKG_VERSION}.tar.xz"
TERMUX_PKG_SHA256="ff507d3c435407b3831ead1ea63f6dea6c778ba6a1f5b45895d5fec6f5c1f982"
TERMUX_PKG_AUTO_UPDATE=true
TERMUX_PKG_DEPENDS="libc++, qt6-qtbase, qt6-qtwayland, libwayland"
TERMUX_PKG_BUILD_DEPENDS="extra-cmake-modules, qt6-qttools, plasma-wayland-protocols, libwayland-protocols"
TERMUX_PKG_EXTRA_CONFIGURE_ARGS="
-DCMAKE_SYSTEM_NAME=Linux
-DKDE_INSTALL_QMLDIR=lib/qt6/qml
-DKDE_INSTALL_QTPLUGINDIR=lib/qt6/plugins
"

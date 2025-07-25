TERMUX_PKG_HOMEPAGE="https://invent.kde.org/plasma/plasma-activities"
TERMUX_PKG_DESCRIPTION="Core components for KDE's Activities"
TERMUX_PKG_LICENSE="LGPL-2.1-or-later"
TERMUX_PKG_MAINTAINER="@termux"
TERMUX_PKG_VERSION="6.4.3"
TERMUX_PKG_SRCURL="https://download.kde.org/stable/plasma/${TERMUX_PKG_VERSION}/plasma-activities-${TERMUX_PKG_VERSION}.tar.xz"
TERMUX_PKG_SHA256="1c8dca746602defacd495b9ae637c1700d3be7e7e3cc5d499a5fd669a0b98ef0"
TERMUX_PKG_AUTO_UPDATE=true
TERMUX_PKG_DEPENDS="libc++, qt6-qtbase, qt6-qtdeclarative, kf6-kcoreaddons, kf6-kconfig"
TERMUX_PKG_BUILD_DEPENDS="extra-cmake-modules, boost, qt6-qtdeclarative, qt6-qttools"
TERMUX_PKG_EXTRA_CONFIGURE_ARGS="
-DCMAKE_SYSTEM_NAME=Linux
-DKDE_INSTALL_QMLDIR=lib/qt6/qml
-DKDE_INSTALL_QTPLUGINDIR=lib/qt6/plugins
"

TERMUX_PKG_HOMEPAGE=https://invent.kde.org/plasma/plasma5support
TERMUX_PKG_DESCRIPTION="Support components for porting from KF5/Qt5 to KF6/Qt6"
TERMUX_PKG_LICENSE="LGPL-2.0-or-later"
TERMUX_PKG_MAINTAINER="@termux"
TERMUX_PKG_VERSION="6.4.3"
TERMUX_PKG_SRCURL="https://download.kde.org/stable/plasma/${TERMUX_PKG_VERSION}/plasma5support-${TERMUX_PKG_VERSION}.tar.xz"
TERMUX_PKG_SHA256="1e89a8935d18d98a8fcbe02ff3477489385bb42a804e543bbb24f043f5cd8cf6"
TERMUX_PKG_AUTO_UPDATE=true
TERMUX_PKG_DEPENDS="libc++, qt6-qtbase, qt6-qtdeclarative, kf6-kconfig, kf6-kcoreaddons, kf6-ki18n, kf6-kio, kf6-kjobwidgets, kf6-kguiaddons, kf6-kservice, kf6-knotifications, kf6-kidletime, kf6-solid, libx11, libxfixes"
TERMUX_PKG_BUILD_DEPENDS="extra-cmake-modules, qt6-qttools, plasma-activities"
TERMUX_PKG_EXTRA_CONFIGURE_ARGS="
-DCMAKE_SYSTEM_NAME=Linux
-DKDE_INSTALL_QMLDIR=lib/qt6/qml
-DKDE_INSTALL_QTPLUGINDIR=lib/qt6/plugins
"

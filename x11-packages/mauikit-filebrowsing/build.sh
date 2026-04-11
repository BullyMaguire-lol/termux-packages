TERMUX_PKG_HOMEPAGE="https://invent.kde.org/maui/mauikit-filebrowsing"
TERMUX_PKG_DESCRIPTION="MauiKit File Browsing utilities and controls"
TERMUX_PKG_LICENSE="LGPL-3.0-only"
TERMUX_PKG_MAINTAINER="@termux"
TERMUX_PKG_VERSION="4.0.2"
TERMUX_PKG_SRCURL="https://download.kde.org/stable/maui/mauikit-filebrowsing/${TERMUX_PKG_VERSION}/mauikit-filebrowsing-${TERMUX_PKG_VERSION}.tar.xz"
TERMUX_PKG_SHA256="cc6f522c6dd9b9ee7cef7adbae56a1a8a9e26cc31dfe2201a117601a10f58d21"
TERMUX_PKG_AUTO_UPDATE=true
TERMUX_PKG_DEPENDS="kf6-kconfig, kf6-kcoreaddons, kf6-ki18n, kf6-kio, kf6-kservice, kf6-solid, libc++, mauikit, qt6-qtbase, qt6-qtdeclarative"
TERMUX_PKG_BUILD_DEPENDS="extra-cmake-modules"
TERMUX_PKG_EXTRA_CONFIGURE_ARGS="
-DCMAKE_SYSTEM_NAME=Linux
-DKDE_INSTALL_QMLDIR=lib/qt6/qml
-DKDE_INSTALL_QTPLUGINDIR=lib/qt6/plugins
"

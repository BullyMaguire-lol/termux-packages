TERMUX_PKG_HOMEPAGE="https://invent.kde.org/maui/mauikit-archiver"
TERMUX_PKG_DESCRIPTION="QtQuick plugin for online archived/compressed files management"
TERMUX_PKG_LICENSE="LGPL-3.0-only"
TERMUX_PKG_MAINTAINER="@termux"
TERMUX_PKG_VERSION="4.0.2"
TERMUX_PKG_SRCURL="https://download.kde.org/stable/maui/mauikit-archiver/${TERMUX_PKG_VERSION}/mauikit-archiver-${TERMUX_PKG_VERSION}.tar.xz"
TERMUX_PKG_SHA256="eb191e4e5cbe3b6d2541f703b267ac6e79d845f9b727dfeae81115650afc8890"
TERMUX_PKG_AUTO_UPDATE=true
TERMUX_PKG_DEPENDS="kf6-karchive, kf6-kcoreaddons, libc++, mauikit, mauikit-filebrowsing, qt6-qtbase, qt6-qtdeclarative"
TERMUX_PKG_BUILD_DEPENDS="extra-cmake-modules"
TERMUX_PKG_EXTRA_CONFIGURE_ARGS="
-DCMAKE_SYSTEM_NAME=Linux
-DKDE_INSTALL_QMLDIR=lib/qt6/qml
-DKDE_INSTALL_QTPLUGINDIR=lib/qt6/plugins
"

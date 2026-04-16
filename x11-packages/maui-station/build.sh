TERMUX_PKG_HOMEPAGE="https://invent.kde.org/maui/station"
TERMUX_PKG_DESCRIPTION="Convergent terminal emulator"
TERMUX_PKG_LICENSE="LGPL-3.0-only"
TERMUX_PKG_MAINTAINER="@termux"
TERMUX_PKG_VERSION="4.0.2"
TERMUX_PKG_SRCURL="https://download.kde.org/stable/maui/station/${TERMUX_PKG_VERSION}/maui-station-${TERMUX_PKG_VERSION}.tar.xz"
TERMUX_PKG_SHA256="09da03d5195532e513a1ed4eb7052b9e395e85064bd819d664e75736291f4f54"
TERMUX_PKG_AUTO_UPDATE=true
TERMUX_PKG_DEPENDS="kf6-kcoreaddons, kf6-ki18n, libc++, mauikit, mauikit-filebrowsing, mauikit-terminal, qt6-qtbase, qt6-qtdeclarative"
TERMUX_PKG_BUILD_DEPENDS="extra-cmake-modules"
TERMUX_PKG_EXTRA_CONFIGURE_ARGS="
-DCMAKE_SYSTEM_NAME=Linux
-DKDE_INSTALL_QMLDIR=lib/qt6/qml
-DKDE_INSTALL_QTPLUGINDIR=lib/qt6/plugins
"

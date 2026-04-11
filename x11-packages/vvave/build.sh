TERMUX_PKG_HOMEPAGE="https://invent.kde.org/maui/vvave"
TERMUX_PKG_DESCRIPTION="Multi-platform media player"
TERMUX_PKG_LICENSE="LGPL-3.0-only"
TERMUX_PKG_MAINTAINER="@termux"
TERMUX_PKG_VERSION="4.0.2"
TERMUX_PKG_SRCURL="https://download.kde.org/stable/maui/vvave/${TERMUX_PKG_VERSION}/vvave-${TERMUX_PKG_VERSION}.tar.xz"
TERMUX_PKG_SHA256="be0e143787252c8028b9c593ca294d4586f93ecdb8cdcd5c797845ceb8eee44f"
TERMUX_PKG_AUTO_UPDATE=true
TERMUX_PKG_DEPENDS="kf6-kcoreaddons, kf6-ki18n, libc++, mauikit, mauikit-accounts, mauikit-filebrowsing, qt6-qtbase, qt6-qtdeclarative, qt6-qtmultimedia, taglib"
TERMUX_PKG_BUILD_DEPENDS="extra-cmake-modules"
TERMUX_PKG_EXTRA_CONFIGURE_ARGS="
-DCMAKE_SYSTEM_NAME=Linux
-DKDE_INSTALL_QMLDIR=lib/qt6/qml
-DKDE_INSTALL_QTPLUGINDIR=lib/qt6/plugins
"

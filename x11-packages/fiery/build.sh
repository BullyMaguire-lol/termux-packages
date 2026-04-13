TERMUX_PKG_HOMEPAGE="https://invent.kde.org/maui/fiery"
TERMUX_PKG_DESCRIPTION="A convergent web browser"
TERMUX_PKG_LICENSE="LGPL-3.0-only"
TERMUX_PKG_MAINTAINER="@termux"
TERMUX_PKG_VERSION="1.0.2"
TERMUX_PKG_SRCURL="https://download.kde.org/stable/maui/fiery/${TERMUX_PKG_VERSION}/maui-fiery-${TERMUX_PKG_VERSION}.tar.xz"
TERMUX_PKG_SHA256="ad668b02b7d020be6abf0fd9b7ef6ebf3e97f3ef4c4bc4f5d1a0a0f92447171f"
TERMUX_PKG_AUTO_UPDATE=true
TERMUX_PKG_DEPENDS="hicolor-icon-theme, kf6-kcoreaddons, kf6-ki18n, libc++, mauikit, mauikit-filebrowsing, qt6-qtbase, qt6-qtdeclarative, qt6-qtwebengine"
TERMUX_PKG_BUILD_DEPENDS="extra-cmake-modules"
TERMUX_PKG_EXCLUDED_ARCHES="i686"
TERMUX_PKG_EXTRA_CONFIGURE_ARGS="
-DCMAKE_SYSTEM_NAME=Linux
-DKDE_INSTALL_QMLDIR=lib/qt6/qml
-DKDE_INSTALL_QTPLUGINDIR=lib/qt6/plugins
"

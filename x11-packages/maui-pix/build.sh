TERMUX_PKG_HOMEPAGE="https://invent.kde.org/maui/pix"
TERMUX_PKG_DESCRIPTION="Image gallery application"
TERMUX_PKG_LICENSE="LGPL-3.0-only"
TERMUX_PKG_MAINTAINER="@termux"
TERMUX_PKG_VERSION="4.0.2"
TERMUX_PKG_SRCURL="https://download.kde.org/stable/maui/pix/${TERMUX_PKG_VERSION}/maui-pix-${TERMUX_PKG_VERSION}.tar.xz"
TERMUX_PKG_SHA256="5159ef16d02e1288c096ce93031d321879a02d5b34d885aba0b845de41dafca0"
TERMUX_PKG_AUTO_UPDATE=true
TERMUX_PKG_DEPENDS="kf6-kcoreaddons, kf6-ki18n, libc++, mauikit, mauikit-filebrowsing, mauikit-imagetools, qt6-qtbase, qt6-qtdeclarative, qt6-qtmultimedia"
TERMUX_PKG_BUILD_DEPENDS="extra-cmake-modules"
TERMUX_PKG_EXTRA_CONFIGURE_ARGS="
-DCMAKE_SYSTEM_NAME=Linux
-DKDE_INSTALL_QMLDIR=lib/qt6/qml
-DKDE_INSTALL_QTPLUGINDIR=lib/qt6/plugins
"

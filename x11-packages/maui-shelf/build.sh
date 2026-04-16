TERMUX_PKG_HOMEPAGE="https://invent.kde.org/maui/shelf"
TERMUX_PKG_DESCRIPTION="Document and EBook collection manager"
TERMUX_PKG_LICENSE="LGPL-3.0-only"
TERMUX_PKG_MAINTAINER="@termux"
TERMUX_PKG_VERSION="4.0.2"
TERMUX_PKG_SRCURL="https://download.kde.org/stable/maui/shelf/${TERMUX_PKG_VERSION}/maui-shelf-${TERMUX_PKG_VERSION}.tar.xz"
TERMUX_PKG_SHA256="53e506d5e0cbf13b02b1387b5d51223a342c9167441446be57c38e51ff6fe6e9"
TERMUX_PKG_AUTO_UPDATE=true
TERMUX_PKG_DEPENDS="kf6-kcoreaddons, kf6-ki18n, libc++, mauikit, mauikit-documents, mauikit-filebrowsing, mauikit-texteditor, qt6-qtbase, qt6-qtdeclarative"
TERMUX_PKG_BUILD_DEPENDS="extra-cmake-modules"
TERMUX_PKG_EXTRA_CONFIGURE_ARGS="
-DCMAKE_SYSTEM_NAME=Linux
-DKDE_INSTALL_QMLDIR=lib/qt6/qml
-DKDE_INSTALL_QTPLUGINDIR=lib/qt6/plugins
"

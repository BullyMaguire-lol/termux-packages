TERMUX_PKG_HOMEPAGE="https://invent.kde.org/maui/mauikit-texteditor"
TERMUX_PKG_DESCRIPTION="MauiKit Text Editor components"
TERMUX_PKG_LICENSE="LGPL-3.0-only"
TERMUX_PKG_MAINTAINER="@termux"
TERMUX_PKG_VERSION="4.0.2"
TERMUX_PKG_SRCURL="https://download.kde.org/stable/maui/mauikit-texteditor/${TERMUX_PKG_VERSION}/mauikit-texteditor-${TERMUX_PKG_VERSION}.tar.xz"
TERMUX_PKG_SHA256="b2cc5943453881ba74755c09f0cd2785fa3654cd58e82121821f347bf9fcdcd5"
TERMUX_PKG_AUTO_UPDATE=true
TERMUX_PKG_DEPENDS="kf6-kcoreaddons, kf6-ki18n, kf6-sonnet, kf6-syntax-highlighting, libc++, mauikit, qt6-qtbase, qt6-qtdeclarative"
TERMUX_PKG_BUILD_DEPENDS="extra-cmake-modules"
TERMUX_PKG_EXTRA_CONFIGURE_ARGS="
-DCMAKE_SYSTEM_NAME=Linux
-DKDE_INSTALL_QMLDIR=lib/qt6/qml
-DKDE_INSTALL_QTPLUGINDIR=lib/qt6/plugins
"

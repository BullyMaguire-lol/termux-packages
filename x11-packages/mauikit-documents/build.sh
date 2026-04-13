TERMUX_PKG_HOMEPAGE="https://invent.kde.org/maui/mauikit-documents"
TERMUX_PKG_DESCRIPTION="MauiKit QtQuick plugins for text editing"
TERMUX_PKG_LICENSE="LGPL-3.0-only"
TERMUX_PKG_MAINTAINER="@termux"
TERMUX_PKG_VERSION="4.0.2"
TERMUX_PKG_SRCURL="https://download.kde.org/stable/maui/mauikit-documents/${TERMUX_PKG_VERSION}/mauikit-documents-${TERMUX_PKG_VERSION}.tar.xz"
TERMUX_PKG_SHA256="0f65615d96dd1283f9ee471589ec85783dc129cf844b4eac247cd69130e1b6d3"
TERMUX_PKG_AUTO_UPDATE=true
TERMUX_PKG_DEPENDS="kf6-karchive, kf6-kcoreaddons, kf6-kfilemetadata, kf6-kguiaddons, kf6-ki18n, kf6-kio, libc++, mauikit, poppler-qt, qt6-qtbase, qt6-qtdeclarative"
TERMUX_PKG_BUILD_DEPENDS="extra-cmake-modules"
TERMUX_PKG_EXTRA_CONFIGURE_ARGS="
-DCMAKE_SYSTEM_NAME=Linux
-DKDE_INSTALL_QMLDIR=lib/qt6/qml
-DKDE_INSTALL_QTPLUGINDIR=lib/qt6/plugins
"

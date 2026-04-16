TERMUX_PKG_HOMEPAGE="https://invent.kde.org/maui/arca"
TERMUX_PKG_DESCRIPTION="Archiver for compressed files"
TERMUX_PKG_LICENSE="LGPL-3.0-only"
TERMUX_PKG_MAINTAINER="@termux"
TERMUX_PKG_VERSION="1.0.2"
TERMUX_PKG_SRCURL="https://download.kde.org/stable/maui/arca/${TERMUX_PKG_VERSION}/arca-${TERMUX_PKG_VERSION}.tar.xz"
TERMUX_PKG_SHA256="19becf4e75a2e2b2a6c8824a83215b88158c469c85997a7a733ddd59b413cd56"
TERMUX_PKG_AUTO_UPDATE=true
TERMUX_PKG_DEPENDS="hicolor-icon-theme, kf6-kcoreaddons, kf6-ki18n, libc++, mauikit, mauikit-archiver, mauikit-documents, mauikit-filebrowsing, mauikit-texteditor, qt6-qtbase, qt6-qtdeclarative"
TERMUX_PKG_BUILD_DEPENDS="extra-cmake-modules"
TERMUX_PKG_EXTRA_CONFIGURE_ARGS="
-DCMAKE_SYSTEM_NAME=Linux
-DKDE_INSTALL_QMLDIR=lib/qt6/qml
-DKDE_INSTALL_QTPLUGINDIR=lib/qt6/plugins
"

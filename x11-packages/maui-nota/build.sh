TERMUX_PKG_HOMEPAGE="https://invent.kde.org/maui/nota"
TERMUX_PKG_DESCRIPTION="Multi-platform text editor"
TERMUX_PKG_LICENSE="LGPL-3.0-only"
TERMUX_PKG_MAINTAINER="@termux"
TERMUX_PKG_VERSION="4.0.2"
TERMUX_PKG_SRCURL="https://download.kde.org/stable/maui/nota/${TERMUX_PKG_VERSION}/nota-${TERMUX_PKG_VERSION}.tar.xz"
TERMUX_PKG_SHA256="08213184a5995085e826571d4b99c5b7cc01c0e9b5a2b5a03007df9c081abe33"
TERMUX_PKG_AUTO_UPDATE=true
TERMUX_PKG_DEPENDS="kf6-kcoreaddons, kf6-ki18n, libc++, mauikit, mauikit-filebrowsing, mauikit-terminal, mauikit-texteditor, qt6-qtbase, qt6-qtdeclarative"
TERMUX_PKG_BUILD_DEPENDS="extra-cmake-modules"
TERMUX_PKG_EXTRA_CONFIGURE_ARGS="
-DCMAKE_SYSTEM_NAME=Linux
-DKDE_INSTALL_QMLDIR=lib/qt6/qml
-DKDE_INSTALL_QTPLUGINDIR=lib/qt6/plugins
"

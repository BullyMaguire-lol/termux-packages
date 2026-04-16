TERMUX_PKG_HOMEPAGE="https://invent.kde.org/maui/index-fm"
TERMUX_PKG_DESCRIPTION="Multi-platform file manager"
TERMUX_PKG_LICENSE="LGPL-3.0-only"
TERMUX_PKG_MAINTAINER="@termux"
TERMUX_PKG_VERSION="4.0.2"
TERMUX_PKG_SRCURL="https://download.kde.org/stable/maui/index/${TERMUX_PKG_VERSION}/index-fm-${TERMUX_PKG_VERSION}.tar.xz"
TERMUX_PKG_SHA256="bb761ead52693efd7408302027b733116dcd7d0997d25c7c8af9e0a72c71c3d5"
TERMUX_PKG_AUTO_UPDATE=true
TERMUX_PKG_DEPENDS="kf6-kcoreaddons, kf6-ki18n, kf6-kio, libc++, mauikit, mauikit-archiver, mauikit-documents, mauikit-filebrowsing, mauikit-terminal, mauikit-texteditor, qt6-qtbase, qt6-qtdeclarative, qt6-qtmultimedia"
TERMUX_PKG_BUILD_DEPENDS="extra-cmake-modules"
TERMUX_PKG_EXTRA_CONFIGURE_ARGS="
-DCMAKE_SYSTEM_NAME=Linux
-DKDE_INSTALL_QMLDIR=lib/qt6/qml
-DKDE_INSTALL_QTPLUGINDIR=lib/qt6/plugins
"

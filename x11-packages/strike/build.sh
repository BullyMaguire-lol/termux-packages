TERMUX_PKG_HOMEPAGE="https://invent.kde.org/maui/strike"
TERMUX_PKG_DESCRIPTION="A simple minimal IDE for the Linux phones"
TERMUX_PKG_LICENSE="LGPL-3.0-only"
TERMUX_PKG_MAINTAINER="@termux"
TERMUX_PKG_VERSION="2.0.0"
TERMUX_PKG_SRCURL="https://download.kde.org/stable/maui/strike/${TERMUX_PKG_VERSION}/maui-strike-${TERMUX_PKG_VERSION}.tar.xz"
TERMUX_PKG_SHA256="b8152e0b776221820dfe6551e30b7de8454614ea8caddf5cee45f7d1980c3d1c"
TERMUX_PKG_AUTO_UPDATE=true
TERMUX_PKG_DEPENDS="kf6-kcoreaddons, kf6-ki18n, kf6-kirigami, libc++, mauikit, mauikit-filebrowsing, mauikit-terminal, mauikit-texteditor, qt6-qtbase, qt6-qtdeclarative"
TERMUX_PKG_BUILD_DEPENDS="extra-cmake-modules"
TERMUX_PKG_EXTRA_CONFIGURE_ARGS="
-DCMAKE_SYSTEM_NAME=Linux
-DKDE_INSTALL_QMLDIR=lib/qt6/qml
-DKDE_INSTALL_QTPLUGINDIR=lib/qt6/plugins
"

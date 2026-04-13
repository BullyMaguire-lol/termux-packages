TERMUX_PKG_HOMEPAGE="https://invent.kde.org/maui/mauikit-terminal"
TERMUX_PKG_DESCRIPTION="Terminal support components for Maui applications"
TERMUX_PKG_LICENSE="LGPL-3.0-only"
TERMUX_PKG_MAINTAINER="@termux"
TERMUX_PKG_VERSION="4.0.2"
TERMUX_PKG_SRCURL="https://download.kde.org/stable/maui/mauikit-terminal/${TERMUX_PKG_VERSION}/mauikit-terminal-${TERMUX_PKG_VERSION}.tar.xz"
TERMUX_PKG_SHA256="278369a818179ab369c8464399e19c58c9376b50e7c7aec49960f83b5b7b93d5"
TERMUX_PKG_AUTO_UPDATE=true
TERMUX_PKG_DEPENDS="kf6-kcoreaddons, kf6-kpty, libc++, mauikit, qt6-qt5compat, qt6-qtbase, qt6-qtdeclarative"
TERMUX_PKG_BUILD_DEPENDS="extra-cmake-modules"
TERMUX_PKG_EXTRA_CONFIGURE_ARGS="
-DCMAKE_SYSTEM_NAME=Linux
-DKDE_INSTALL_QMLDIR=lib/qt6/qml
-DKDE_INSTALL_QTPLUGINDIR=lib/qt6/plugins
"

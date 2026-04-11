TERMUX_PKG_HOMEPAGE="https://invent.kde.org/maui/mauikit"
TERMUX_PKG_DESCRIPTION="Templated convergent controls and multi-platform utilities for Maui applications"
TERMUX_PKG_LICENSE="LGPL-3.0-only"
TERMUX_PKG_MAINTAINER="@termux"
TERMUX_PKG_VERSION="4.0.2"
TERMUX_PKG_SRCURL="https://download.kde.org/stable/maui/mauikit/${TERMUX_PKG_VERSION}/mauikit-${TERMUX_PKG_VERSION}.tar.xz"
TERMUX_PKG_SHA256="054dc0e15242ffa6bb9b8b25515cebfc9a02347b679f3907dcb80673ca93dd40"
TERMUX_PKG_AUTO_UPDATE=true
TERMUX_PKG_DEPENDS="kf6-kcoreaddons, kf6-ki18n, kf6-kirigami, kf6-knotifications, kf6-kwindowsystem, kf6-purpose, libc++, mauiman, qt6-qtbase, qt6-qtdeclarative, qt6-qtmultimedia, qt6-qtsvg"
TERMUX_PKG_BUILD_DEPENDS="extra-cmake-modules"
TERMUX_PKG_EXTRA_CONFIGURE_ARGS="
-DCMAKE_SYSTEM_NAME=Linux
-DKDE_INSTALL_QMLDIR=lib/qt6/qml
-DKDE_INSTALL_QTPLUGINDIR=lib/qt6/plugins
"

TERMUX_PKG_HOMEPAGE="https://invent.kde.org/maui/mauikit-accounts"
TERMUX_PKG_DESCRIPTION="MauiKit utilities to handle User Accounts"
TERMUX_PKG_LICENSE="LGPL-3.0-only"
TERMUX_PKG_MAINTAINER="@termux"
TERMUX_PKG_VERSION="4.0.2"
TERMUX_PKG_SRCURL="https://download.kde.org/stable/maui/mauikit-accounts/${TERMUX_PKG_VERSION}/mauikit-accounts-${TERMUX_PKG_VERSION}.tar.xz"
TERMUX_PKG_SHA256="ba3616e9151d4838a1083765e3cf5241bd97e4c6796ead22493f4de91f286427"
TERMUX_PKG_AUTO_UPDATE=true
TERMUX_PKG_DEPENDS="kf6-kcoreaddons, libc++, mauikit, qt6-qtbase, qt6-qtdeclarative"
TERMUX_PKG_BUILD_DEPENDS="extra-cmake-modules"
TERMUX_PKG_EXTRA_CONFIGURE_ARGS="
-DCMAKE_SYSTEM_NAME=Linux
-DKDE_INSTALL_QMLDIR=lib/qt6/qml
-DKDE_INSTALL_QTPLUGINDIR=lib/qt6/plugins
"

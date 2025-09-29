TERMUX_PKG_HOMEPAGE="https://invent.kde.org/frameworks/kdesu"
TERMUX_PKG_DESCRIPTION="Integration with su for elevated privileges"
TERMUX_PKG_LICENSE="LGPL-2.0-only, LGPL-3.0-only"
TERMUX_PKG_MAINTAINER="@termux"
TERMUX_PKG_VERSION="6.18.0"
_KF6_MINOR_VERSION="${TERMUX_PKG_VERSION%.*}"
TERMUX_PKG_SRCURL="https://download.kde.org/stable/frameworks/${_KF6_MINOR_VERSION}/kdesu-${TERMUX_PKG_VERSION}.tar.xz"
TERMUX_PKG_SHA256="3203b047113cf08bca3981ede657e45b417a7cd0f2879bb4f9e901ad4e594616"
TERMUX_PKG_AUTO_UPDATE=true
TERMUX_PKG_DEPENDS="qt6-qtbase, kf6-kconfig, kf6-kcoreaddons, kf6-ki18n, kf6-kpty"
TERMUX_PKG_BUILD_DEPENDS="extra-cmake-modules"
TERMUX_PKG_EXTRA_CONFIGURE_ARGS="
-DCMAKE_SYSTEM_NAME=Linux
-DKDE_INSTALL_QMLDIR=lib/qt6/qml
-DKDE_INSTALL_QTPLUGINDIR=lib/qt6/plugins
"

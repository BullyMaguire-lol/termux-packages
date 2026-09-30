TERMUX_PKG_HOMEPAGE="https://invent.kde.org/plasma/layer-shell-qt"
TERMUX_PKG_DESCRIPTION="Qt component to allow applications to make use of the Wayland wl-layer-shell protocol"
TERMUX_PKG_LICENSE="LGPL-2.0"
TERMUX_PKG_MAINTAINER="@termux"
TERMUX_PKG_VERSION="6.8.2"
TERMUX_PKG_SRCURL=https://download.kde.org/stable/plasma/${TERMUX_PKG_VERSION}/layer-shell-qt-${TERMUX_PKG_VERSION}.tar.xz
TERMUX_PKG_SHA256=8866504834e4727e30ca3674207781dc9a3ac50c8f042bbbc8d8cfdf2ece32a1
TERMUX_PKG_AUTO_UPDATE=true
TERMUX_PKG_DEPENDS="libc++, qt6-qtbase, qt6-qtdeclarative, libwayland"
TERMUX_PKG_BUILD_DEPENDS="extra-cmake-modules, libwayland-cross-scanner, libwayland-protocols"
TERMUX_PKG_EXTRA_CONFIGURE_ARGS="
-DCMAKE_SYSTEM_NAME=Linux
-DKDE_INSTALL_QMLDIR=lib/qt6/qml
-DKDE_INSTALL_QTPLUGINDIR=lib/qt6/plugins
"

termux_step_pre_configure() {
	termux_setup_wayland_cross_pkg_config_wrapper
}

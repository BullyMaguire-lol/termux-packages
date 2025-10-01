TERMUX_PKG_HOMEPAGE="https://www.qt.io"
TERMUX_PKG_DESCRIPTION="Provides access to sensor hardware and motion gesture recognition"
TERMUX_PKG_LICENSE="GPL-3.0-only, LGPL-3.0-only"
TERMUX_PKG_MAINTAINER="@termux-user"
TERMUX_PKG_VERSION="6.9.3"
TERMUX_PKG_SRCURL="https://download.qt.io/official_releases/qt/${TERMUX_PKG_VERSION%.*}/${TERMUX_PKG_VERSION}/submodules/qtsensors-everywhere-src-${TERMUX_PKG_VERSION}.tar.xz"
TERMUX_PKG_SHA256="a2db5168e5f37631a4ad087deaed69abdfa0be6d182f56e8604764658df92f68"
TERMUX_PKG_AUTO_UPDATE=true
TERMUX_PKG_DEPENDS="libc++, qt6-qtbase"
TERMUX_PKG_BUILD_DEPENDS="ninja, cmake, qt6-qtdeclarative, git"
TERMUX_PKG_EXTRA_CONFIGURE_ARGS="
-DCMAKE_SYSTEM_NAME=Linux
"

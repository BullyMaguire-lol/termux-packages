TERMUX_PKG_HOMEPAGE="https://www.qt.io"
TERMUX_PKG_DESCRIPTION="Helps you create viable mapping solutions using the data available from some of the popular location services"
TERMUX_PKG_LICENSE="GPL-3.0-only, LGPL-3.0-only"
TERMUX_PKG_MAINTAINER="@termux-user"
TERMUX_PKG_VERSION="6.9.2"
TERMUX_PKG_SRCURL="https://download.qt.io/official_releases/qt/${TERMUX_PKG_VERSION%.*}/${TERMUX_PKG_VERSION}/submodules/qtlocation-everywhere-src-${TERMUX_PKG_VERSION}.tar.xz"
TERMUX_PKG_SHA256="5a45ed1967958982899b79891afc0b4530cf2e59d3b1a57af6dfdc645e1c73f9"
TERMUX_PKG_AUTO_UPDATE=true
TERMUX_PKG_DEPENDS="qt6-qtbase, qt6-qtpositioning, qt6-qtdeclarative"
TERMUX_PKG_EXTRA_CONFIGURE_ARGS="
-DCMAKE_SYSTEM_NAME=Linux
"

TERMUX_PKG_HOMEPAGE="https://invent.kde.org/frameworks/ktexteditor"
TERMUX_PKG_DESCRIPTION="Advanced embeddable text editor"
TERMUX_PKG_LICENSE="LGPL-2.0-only, LGPL-3.0-only"
TERMUX_PKG_MAINTAINER="@termux"
TERMUX_PKG_VERSION="6.18.0"
_KF6_MINOR_VERSION="${TERMUX_PKG_VERSION%.*}"
TERMUX_PKG_SRCURL="https://download.kde.org/stable/frameworks/${_KF6_MINOR_VERSION}/ktexteditor-${TERMUX_PKG_VERSION}.tar.xz"
TERMUX_PKG_SHA256="4f8abb0436a0c6ca501f7be391975756cb07f8e403d3afe7ec2f02d12bf7b516"
TERMUX_PKG_AUTO_UPDATE=true
TERMUX_PKG_DEPENDS="qt6-qtbase, qt6-qttools, qt6-qtspeech, kf6-karchive, kf6-kconfig, kf6-kguiaddons, kf6-ki18n, kf6-kio, kf6-kparts, kf6-sonnet, kf6-syntax-highlighting"
TERMUX_PKG_BUILD_DEPENDS="extra-cmake-modules"
TERMUX_PKG_EXTRA_CONFIGURE_ARGS="
-DCMAKE_SYSTEM_NAME=Linux
-DKDE_INSTALL_QMLDIR=lib/qt6/qml
-DKDE_INSTALL_QTPLUGINDIR=lib/qt6/plugins
"

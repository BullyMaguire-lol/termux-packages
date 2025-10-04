TERMUX_PKG_HOMEPAGE="https://apps.kde.org/kate"
TERMUX_PKG_DESCRIPTION="Advanced text editor"
TERMUX_PKG_LICENSE="GPL-2.0-or-later"
TERMUX_PKG_MAINTAINER="@termux"
TERMUX_PKG_VERSION="25.08.1"
TERMUX_PKG_SRCURL="https://download.kde.org/stable/release-service/${TERMUX_PKG_VERSION}/src/kate-${TERMUX_PKG_VERSION}.tar.xz"
TERMUX_PKG_SHA256=6b5f9d240da5a7668e2643e4153ab63bf7842ec0605d5d58b3f5aa3e5f2be8e1
TERMUX_PKG_AUTO_UPDATE=true
TERMUX_PKG_DEPENDS="qt6-qtbase, kf6-ki18n, kf6-kcoreaddons, kf6-kguiaddons, kf6-kcrash, kf6-kiconthemes, kf6-ktexteditor"
TERMUX_PKG_BUILD_DEPENDS="extra-cmake-modules"
TERMUX_PKG_EXTRA_CONFIGURE_ARGS="
-DCMAKE_SYSTEM_NAME=Linux
-DBUILD_DOC=OFF
-DKDE_INSTALL_QMLDIR=lib/qt6/qml
-DKDE_INSTALL_QTPLUGINDIR=lib/qt6/plugins
"

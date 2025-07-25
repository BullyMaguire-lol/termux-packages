TERMUX_PKG_HOMEPAGE="https://invent.kde.org/plasma/plasma-activities-stats"
TERMUX_PKG_DESCRIPTION="Provides usage data for KDE activities"
TERMUX_PKG_LICENSE="LGPL-2.1-or-later"
TERMUX_PKG_MAINTAINER="@termux"
TERMUX_PKG_VERSION="6.4.3"
TERMUX_PKG_SRCURL="https://download.kde.org/stable/plasma/${TERMUX_PKG_VERSION}/plasma-activities-stats-${TERMUX_PKG_VERSION}.tar.xz"
TERMUX_PKG_SHA256="991002e3da9b5969b9583cd169050a23aacbe02f2d7d4ab1a19f5bd7c72b3b6b"
TERMUX_PKG_AUTO_UPDATE=true
TERMUX_PKG_DEPENDS="libc++, qt6-qttools, plasma-activities, kf6-kconfig"
TERMUX_PKG_BUILD_DEPENDS="extra-cmake-modules, qt6-qttools"
TERMUX_PKG_EXTRA_CONFIGURE_ARGS="
-DCMAKE_SYSTEM_NAME=Linux
-DKDE_INSTALL_QMLDIR=lib/qt6/qml
-DKDE_INSTALL_QTPLUGINDIR=lib/qt6/plugins
"

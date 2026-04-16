TERMUX_PKG_HOMEPAGE="https://invent.kde.org/maui/buho"
TERMUX_PKG_DESCRIPTION="Task and note keeper"
TERMUX_PKG_LICENSE="LGPL-3.0-only"
TERMUX_PKG_MAINTAINER="@termux"
TERMUX_PKG_VERSION="4.0.2"
TERMUX_PKG_SRCURL="https://download.kde.org/stable/maui/buho/${TERMUX_PKG_VERSION}/buho-${TERMUX_PKG_VERSION}.tar.xz"
TERMUX_PKG_SHA256="21840a33d0165018d762064c668e05957824cf19f56963d7fda8583d28a1b8fc"
TERMUX_PKG_AUTO_UPDATE=true
TERMUX_PKG_DEPENDS="hicolor-icon-theme, kf6-kcoreaddons, kf6-ki18n, libc++, mauikit, mauikit-accounts, mauikit-filebrowsing, mauikit-texteditor, qt6-qtbase, qt6-qtdeclarative"
TERMUX_PKG_BUILD_DEPENDS="extra-cmake-modules"
TERMUX_PKG_EXTRA_CONFIGURE_ARGS="
-DCMAKE_SYSTEM_NAME=Linux
-DKDE_INSTALL_QMLDIR=lib/qt6/qml
-DKDE_INSTALL_QTPLUGINDIR=lib/qt6/plugins
"

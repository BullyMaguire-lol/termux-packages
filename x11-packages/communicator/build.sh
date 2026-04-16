TERMUX_PKG_HOMEPAGE="https://invent.kde.org/maui/communicator"
TERMUX_PKG_DESCRIPTION="Contacts and dialer application"
TERMUX_PKG_LICENSE="LGPL-3.0-only"
TERMUX_PKG_MAINTAINER="@termux"
TERMUX_PKG_VERSION="4.0.2"
TERMUX_PKG_SRCURL="https://download.kde.org/stable/maui/communicator/${TERMUX_PKG_VERSION}/maui-communicator-${TERMUX_PKG_VERSION}.tar.xz"
TERMUX_PKG_SHA256="60bc8b5b5f56d81229fccfe1fa52f256ff0b1326b6dc6eb62544939aa64d31fb"
TERMUX_PKG_AUTO_UPDATE=true
TERMUX_PKG_DEPENDS="hicolor-icon-theme, kf6-kcontacts, kf6-kcoreaddons, kf6-ki18n, kf6-kio, kf6-kpeople, libc++, mauikit, mauikit-filebrowsing, qt6-qtbase, qt6-qtdeclarative"
TERMUX_PKG_BUILD_DEPENDS="extra-cmake-modules"
TERMUX_PKG_EXTRA_CONFIGURE_ARGS="
-DCMAKE_SYSTEM_NAME=Linux
-DKDE_INSTALL_QMLDIR=lib/qt6/qml
-DKDE_INSTALL_QTPLUGINDIR=lib/qt6/plugins
"

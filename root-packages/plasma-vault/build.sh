TERMUX_PKG_HOMEPAGE="https://invent.kde.org/plasma/plasma-vault"
TERMUX_PKG_DESCRIPTION="Plasma applet and services for creating encrypted vaults"
TERMUX_PKG_LICENSE="LGPL-2.0-or-later"
TERMUX_PKG_MAINTAINER="@termux"
TERMUX_PKG_VERSION="6.5.5"
TERMUX_PKG_SRCURL="https://download.kde.org/stable/plasma/${TERMUX_PKG_VERSION}/plasma-vault-${TERMUX_PKG_VERSION}.tar.xz"
TERMUX_PKG_SHA256="3d1dcff463bc6cb7c328624f7a9e9e32591a82d283bc89b19eb9e0769ccafa70"
TERMUX_PKG_AUTO_UPDATE=true
TERMUX_PKG_DEPENDS="gocryptfs, kf6-kconfig, kf6-kcoreaddons, kf6-kdbusaddons, kf6-ki18n, kf6-kio, kf6-kirigami, kf6-kitemmodels, kf6-kservice, kf6-kwidgetsaddons, libc++, libksysguard, libplasma, plasma-activities, plasma-workspace, qt6-qtbase, qt6-qtdeclarative"
TERMUX_PKG_BUILD_DEPENDS="extra-cmake-modules"
TERMUX_PKG_EXTRA_CONFIGURE_ARGS="
-DCMAKE_SYSTEM_NAME=Linux
-DKDE_INSTALL_QMLDIR=lib/qt6/qml
-DKDE_INSTALL_QTPLUGINDIR=lib/qt6/plugins
"

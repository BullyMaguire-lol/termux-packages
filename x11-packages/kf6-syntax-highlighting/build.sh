TERMUX_PKG_HOMEPAGE="https://invent.kde.org/frameworks/syntax-highlighting"
TERMUX_PKG_DESCRIPTION="Syntax highlighting engine for structured text and code"
TERMUX_PKG_LICENSE="LGPL-2.0-only, LGPL-3.0-only"
TERMUX_PKG_MAINTAINER="@termux"
TERMUX_PKG_VERSION="6.18.0"
_KF6_MINOR_VERSION="${TERMUX_PKG_VERSION%.*}"
TERMUX_PKG_SRCURL="https://download.kde.org/stable/frameworks/${_KF6_MINOR_VERSION}/syntax-highlighting-${TERMUX_PKG_VERSION}.tar.xz"
TERMUX_PKG_SHA256="8be8057221a982c8d1fe42f95454fac9610eb51975226c6652689293cd335bfd"
TERMUX_PKG_AUTO_UPDATE=true
TERMUX_PKG_HOSTBUILD=true
TERMUX_PKG_DEPENDS="qt6-qtbase, qt6-qtspeech, qt6-qttools"
TERMUX_PKG_BUILD_DEPENDS="extra-cmake-modules"
TERMUX_PKG_EXTRA_CONFIGURE_ARGS="
-DCMAKE_SYSTEM_NAME=Linux
-DKDE_INSTALL_QMLDIR=lib/qt6/qml
-DKDE_INSTALL_QTPLUGINDIR=lib/qt6/plugins
-DKATEHIGHLIGHTINGINDEXER_EXECUTABLE=${TERMUX_PKG_HOSTBUILD_DIR}/bin/katehighlightingindexer
"

termux_step_host_build() {
	termux_setup_cmake
	termux_setup_ninja

	cmake \
		-G Ninja \
		-S "${TERMUX_PKG_SRCDIR}" \
		-B "${TERMUX_PKG_HOSTBUILD_DIR}" \
		-DCMAKE_BUILD_TYPE=Release \
		-DCMAKE_INSTALL_PREFIX="$TERMUX_PREFIX/opt/kf6/cross" \
		-DCMAKE_PREFIX_PATH="$TERMUX_PREFIX/opt/qt6/cross/lib/cmake" \
		-DCMAKE_MODULE_PATH="$TERMUX_PREFIX/share/ECM/modules" \
		-DKDE_INSTALL_LIBEXECDIR_KF=lib/libexec/kf6 \
		-DKDE_INSTALL_CMAKEPACKAGEDIR=lib/cmake \
		-DECM_DIR="$TERMUX_PREFIX/share/ECM/cmake" \
		-DTERMUX_PREFIX="$TERMUX_PREFIX" \
		-DCMAKE_INSTALL_LIBDIR=lib \
		-DTOOLS_ONLY=ON
	ninja \
		-j ${TERMUX_PKG_MAKE_PROCESSES} \
		install
}

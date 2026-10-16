TERMUX_PKG_HOMEPAGE=https://www.qt.io/
TERMUX_PKG_DESCRIPTION="Qt module and API for defining 3D content in Qt Quick"
TERMUX_PKG_LICENSE="GPL-3.0"
TERMUX_PKG_MAINTAINER="@termux"
TERMUX_PKG_VERSION="6.12.0"
TERMUX_PKG_SRCURL="https://download.qt.io/official_releases/qt/${TERMUX_PKG_VERSION%.*}/${TERMUX_PKG_VERSION}/submodules/qtquick3d-everywhere-src-${TERMUX_PKG_VERSION}.tar.xz"
TERMUX_PKG_SHA256=6ced6edbd25fb5a632fe770ae820b376bf50233e8d62002c79a69a505a2e429e
TERMUX_PKG_DEPENDS="assimp, libc++, qt6-qtbase (>= ${TERMUX_PKG_VERSION}), qt6-qtdeclarative (>= ${TERMUX_PKG_VERSION}), qt6-qtshadertools (>= ${TERMUX_PKG_VERSION})"
TERMUX_PKG_HOSTBUILD=true
TERMUX_PKG_AUTO_UPDATE=true
TERMUX_PKG_UPDATE_VERSION_REGEXP='v\d+\.\d+\.\d+(?!-)'
TERMUX_PKG_EXTRA_CONFIGURE_ARGS="
-DCMAKE_SYSTEM_NAME=Linux
-DINPUT_openxr=no
-DFEATURE_quick3dxr_openxr=OFF
"

termux_pkg_auto_update() {
	# use GitHub API for Qt packages because Repology is unreliable for Qt
	# All Qt updates are published by upstream simultaneously, so the qtbase
	# repository can be used for all Qt packages
	local latest_tags
	latest_tags="$(
		TERMUX_PKG_SRCURL="https://github.com/qt/qtbase" \
		termux_github_api_get_tag
	)"

	termux_pkg_upgrade_version "${latest_tags}"
}

termux_step_host_build() {
	termux_setup_cmake
	termux_setup_ninja

	cmake \
		-G Ninja \
		-S ${TERMUX_PKG_SRCDIR} \
		-DCMAKE_BUILD_TYPE=MinSizeRel \
		-DCMAKE_INSTALL_PREFIX=${TERMUX_PREFIX}/opt/qt6/cross \
		-DINPUT_openxr=no \
		-DFEATURE_quick3dxr_openxr=OFF
	ninja \
		-j ${TERMUX_PKG_MAKE_PROCESSES} \
		install
}

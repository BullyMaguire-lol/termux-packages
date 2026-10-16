TERMUX_PKG_HOMEPAGE=https://www.qt.io/
TERMUX_PKG_DESCRIPTION="Qt module for 2D and 3D data visualization in Qt Quick and Qt Widgets"
TERMUX_PKG_LICENSE="GPL-3.0"
TERMUX_PKG_MAINTAINER="@termux"
TERMUX_PKG_VERSION="6.12.0"
TERMUX_PKG_SRCURL="https://download.qt.io/official_releases/qt/${TERMUX_PKG_VERSION%.*}/${TERMUX_PKG_VERSION}/submodules/qtgraphs-everywhere-src-${TERMUX_PKG_VERSION}.tar.xz"
TERMUX_PKG_SHA256=18c4e968785447051d94b01f8e3c975e31ddc46065c0777443cecc50753a4d8c
TERMUX_PKG_DEPENDS="libc++, qt6-qtbase (>= ${TERMUX_PKG_VERSION}), qt6-qtdeclarative (>= ${TERMUX_PKG_VERSION}), qt6-qtquick3d (>= ${TERMUX_PKG_VERSION})"
TERMUX_PKG_BUILD_DEPENDS="qt6-qtshadertools (>= ${TERMUX_PKG_VERSION})"
TERMUX_PKG_NO_STATICSPLIT=true
TERMUX_PKG_AUTO_UPDATE=true
TERMUX_PKG_UPDATE_VERSION_REGEXP='v\d+\.\d+\.\d+(?!-)'
TERMUX_PKG_EXTRA_CONFIGURE_ARGS="
-DCMAKE_SYSTEM_NAME=Linux
-DFEATURE_graphs_2d=ON
-DFEATURE_graphs_3d=ON
-DFEATURE_graphs_2d_high_performance_backend=OFF
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

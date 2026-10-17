TERMUX_PKG_HOMEPAGE="https://invent.kde.org/libraries/cxx-rust-cssparser"
TERMUX_PKG_DESCRIPTION="C++ bindings for the Rust cssparser crate"
TERMUX_PKG_LICENSE="LGPL-2.1, LGPL-3.0"
TERMUX_PKG_MAINTAINER="@termux"
TERMUX_PKG_VERSION="1.1.0"
TERMUX_PKG_SRCURL="https://download.kde.org/stable/cxx-rust-cssparser/cxx-rust-cssparser-${TERMUX_PKG_VERSION}.tar.xz"
TERMUX_PKG_SHA256=c88f883f67d132240f7ef5c8b8fe4f743a79c448b98ac88f2be3b68264840358
TERMUX_PKG_AUTO_UPDATE=true
TERMUX_PKG_DEPENDS="libc++"
TERMUX_PKG_BUILD_DEPENDS="corrosion, extra-cmake-modules"
TERMUX_PKG_EXTRA_CONFIGURE_ARGS="
-DCMAKE_SYSTEM_NAME=Linux
-DBUILD_DOCS=OFF
"

termux_step_pre_configure() {
	termux_setup_rust

	[[ "${TERMUX_ARCH}" == "arm" ]] && TERMUX_PKG_EXTRA_CONFIGURE_ARGS+=" -DCMAKE_ANDROID_ARM_MODE=ON"

	TERMUX_PKG_EXTRA_CONFIGURE_ARGS+=" -DRust_CARGO_TARGET=$CARGO_TARGET_NAME"
}

TERMUX_PKG_HOMEPAGE="https://ocaml.org/"
TERMUX_PKG_DESCRIPTION="A functional language with OO extensions"
TERMUX_PKG_LICENSE="custom"
TERMUX_PKG_LICENSE_FILE="LICENSE"
TERMUX_PKG_MAINTAINER="@termux"
TERMUX_PKG_VERSION="5.4.1"
TERMUX_PKG_SRCURL="https://github.com/ocaml/ocaml/archive/refs/tags/${TERMUX_PKG_VERSION}.tar.gz"
TERMUX_PKG_SHA256="d4528517aaa1a44b8e2b1bc109a1ed0a5e0014f3ddc4feb8906b11a7e063e89a"
TERMUX_PKG_AUTO_UPDATE=true
TERMUX_PKG_DEPENDS="libc++, ncurses, tk"
TERMUX_PKG_EXCLUDED_ARCHES="i686, arm"

termux_step_configure() {
	./configure \
		--prefix="$TERMUX_PREFIX" \
		--host="$TERMUX_HOST_PLATFORM" \
		CC="$CC" \
		LIBS="-L$TERMUX_PREFIX/lib -landroid-shmem"

		cat config.log
}

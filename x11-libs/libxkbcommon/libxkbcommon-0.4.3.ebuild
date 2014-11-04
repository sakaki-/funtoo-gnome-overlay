# Distributed under the terms of the GNU General Public License v2

EAPI="5"
XORG_EAUTORECONF="yes"
XORG_MULTILIB="yes"

XORG_BASE_INDIVIDUAL_URI=""
SRC_URI="http://xkbcommon.org/download/${P}.tar.xz"
KEYWORDS="*"

inherit xorg-2 ${GIT_ECLASS}

DESCRIPTION="X.Org xkbcommon library"
IUSE="X doc"

DEPEND="sys-devel/bison
	sys-devel/flex
	X? ( >=x11-libs/libxcb-1.10[${MULTILIB_USEDEP},xkb] )
	>=x11-proto/xproto-7.0.24[${MULTILIB_USEDEP}]
	>=x11-proto/kbproto-1.0.6-r1[${MULTILIB_USEDEP}]
	doc? ( app-doc/doxygen )"
RDEPEND=""

pkg_setup() {
	XORG_CONFIGURE_OPTIONS=(
		--with-xkb-config-root="${EPREFIX}/usr/share/X11/xkb"
		$(use X || use_enable X x11)
		$(use_with doc doxygen)
	)
	xorg-2_pkg_setup
}

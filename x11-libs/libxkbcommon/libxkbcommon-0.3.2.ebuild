# Distributed under the terms of the GNU General Public License v2

EAPI="5"
XORG_EAUTORECONF="yes"

XORG_BASE_INDIVIDUAL_URI=""
SRC_URI="http://xkbcommon.org/download/${P}.tar.xz"
KEYWORDS="*"

inherit xorg-2 ${GIT_ECLASS}

DESCRIPTION="X.Org xkbcommon library"
IUSE="doc"

DEPEND="sys-devel/bison
	sys-devel/flex
	x11-proto/xproto
	>=x11-proto/kbproto-1.0.5
	doc? ( app-doc/doxygen )"
RDEPEND=""

XORG_CONFIGURE_OPTIONS=(
	--with-xkb-config-root="${EPREFIX}/usr/share/X11/xkb" $(use_with doc doxygen)
)

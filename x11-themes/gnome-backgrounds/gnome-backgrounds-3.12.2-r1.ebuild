# Distributed under the terms of the GNU General Public License v2

EAPI="5"
GCONF_DEBUG="no"

inherit eutils gnome2

DESCRIPTION="A set of backgrounds packaged with the GNOME desktop"
HOMEPAGE="https://git.gnome.org/browse/gnome-backgrounds"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="*"
IUSE=""

RDEPEND=""
DEPEND="
	>=dev-util/intltool-0.40.0
	sys-devel/gettext
"

src_prepare() {
	epatch ${FILESDIR}/${P}-restore-3.10-locked-background.patch

	gnome2_src_prepare
}

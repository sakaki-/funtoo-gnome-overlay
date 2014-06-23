# Distributed under the terms of the GNU General Public License v2

EAPI="3"
GCONF_DEBUG="no"
inherit gnome2

DESCRIPTION="GNOME JavaScript common modules and tests"
HOMEPAGE="http://gnome.org/"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~alpha amd64 ~arm ~ia64 ~ppc ~ppc64 ~sparc x86 ~amd64-fbsd"
IUSE=""

RDEPEND=""
DEPEND="sys-devel/gettext
	virtual/pkgconfig
	>=dev-util/intltool-0.35"
DOCS="ChangeLog"

G2CONF="${G2CONF} --disable-seed --disable-gjs"

src_install() {
	gnome2_src_install

	rm -rf "${ED}"/usr/doc
}

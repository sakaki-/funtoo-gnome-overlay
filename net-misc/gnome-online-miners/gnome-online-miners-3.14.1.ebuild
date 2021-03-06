# Distributed under the terms of the GNU General Public License v2

EAPI="5"
GCONF_DEBUG="no"

inherit gnome2

DESCRIPTION="Crawls through your online content"
HOMEPAGE="https://wiki.gnome.org/Projects/GnomeOnlineMiners"

LICENSE="GPL-2+"
SLOT="0"
IUSE=""
KEYWORDS="*"

RDEPEND="
	>=dev-libs/libgdata-0.16.0:0=[gnome]
	>=dev-libs/glib-2.42.0:2
	>=net-libs/gnome-online-accounts-3.14
	>=media-libs/grilo-0.2.11:0.2
	>=net-libs/libgfbgraph-0.2.2:0.2
	>=net-libs/libzapojit-0.0.2
	>=app-misc/tracker-1.2.2:0=
"
DEPEND="${RDEPEND}
	virtual/pkgconfig
"

src_configure() {
	gnome2_src_configure --disable-static
}

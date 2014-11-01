# Distributed under the terms of the GNU General Public License v2

EAPI="5"
GCONF_DEBUG="no"
VALA_MIN_API_VERSION="0.26"
VALA_MAX_API_VERSION="0.26"

inherit gnome-games vala

DESCRIPTION="Test your logic skills in this number grid puzzle"
HOMEPAGE="https://wiki.gnome.org/Apps/Sudoku"

LICENSE="LGPL-2+"
SLOT="0"
KEYWORDS="~*"
IUSE=""

RDEPEND="
	$(vala_depend)
	>=dev-libs/glib-2.40:2
	dev-libs/libgee:0.8[introspection]
	dev-libs/json-glib
	dev-libs/qqwing
	x11-libs/gdk-pixbuf:2[introspection]
	>=x11-libs/gtk+-3.14.3:3[introspection]
	x11-libs/pango[introspection]
"
DEPEND="${RDEPEND}
	$(vala_depend)
	app-text/yelp-tools
	dev-util/appdata-tools
	>=dev-util/intltool-0.50
	sys-devel/gettext
	virtual/pkgconfig
"

src_prepare() {
	vala_src_prepare
	gnome-games_src_prepare
}

src_configure() {
	# Workaround until we know how to fix bug #475318
	gnome-games_src_configure \
		--prefix="${EPREFIX}/usr" \
		--bindir="${GAMES_BINDIR}"
}

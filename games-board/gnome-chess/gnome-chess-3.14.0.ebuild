# Distributed under the terms of the GNU General Public License v2

EAPI="5"
GCONF_DEBUG="no"
VALA_MIN_API_VERSION="0.24"

inherit gnome-games vala

DESCRIPTION="Play the classic two-player boardgame of chess"
HOMEPAGE="https://wiki.gnome.org/Apps/Chess"

LICENSE="LGPL-2+"
SLOT="0"
KEYWORDS="*"
IUSE=""

RDEPEND="
	>=dev-libs/glib-2.42.0:2
	>=gnome-base/librsvg-2.40.0
	virtual/glu
	virtual/opengl
	>=x11-libs/gtk+-3.14.0:3
	x11-libs/libX11
"
DEPEND="${RDEPEND}
	$(vala_depend)
	app-text/yelp-tools
	>=dev-util/intltool-0.50
	sys-devel/gettext
	virtual/pkgconfig
"

src_prepare() {
	vala_src_prepare
	gnome-games_src_prepare
}

src_configure() {
    gnome-games_src_configure APPDATA_VALIDATE=$(type -P true)
}

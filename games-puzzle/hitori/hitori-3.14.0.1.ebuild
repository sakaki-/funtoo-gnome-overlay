# Distributed under the terms of the GNU General Public License v2

EAPI="5"
GCONF_DEBUG="no"

inherit gnome-games

DESCRIPTION="Small application written to allow one to play the eponymous puzzle game"
HOMEPAGE="https://wiki.gnome.org/Apps/Hitori"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="*"
IUSE=""

RDEPEND="
	dev-libs/glib:2
	>=x11-libs/cairo-1.4.0
	>=x11-libs/gtk+-3.14.0:3
"
DEPEND="${RDEPEND}
	>=dev-util/intltool-0.50
	sys-devel/gettext
	virtual/pkgconfig
"

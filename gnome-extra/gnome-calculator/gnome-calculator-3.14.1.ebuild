# Distributed under the terms of the GNU General Public License v2

EAPI="5"
GCONF_DEBUG="no"

inherit gnome2

DESCRIPTION="A calculator application for GNOME"
HOMEPAGE="https://wiki.gnome.org/Apps/Calculator"

LICENSE="GPL-2"
SLOT="0"
IUSE=""
KEYWORDS="*"

COMMON_DEPEND="
	>=dev-libs/glib-2.42.0:2
	dev-libs/libxml2:2
	>=x11-libs/gtk+-3.14.0:3
	>=x11-libs/gtksourceview-3.14.0:3.0
"
RDEPEND="${COMMON_DEPEND}
	!<gnome-extra/gnome-utils-2.3
	!gnome-extra/gcalctool
"
DEPEND="${COMMON_DEPEND}
	>=dev-util/intltool-0.50
	sys-devel/gettext
	virtual/pkgconfig
"

src_configure() {
	gnome2_src_configure \
		ITSTOOL=$(type -P true) \
		VALAC=$(type -P true)
}

# Distributed under the terms of the GNU General Public License v2

EAPI="5"
GCONF_DEBUG="no"

inherit eutils gnome2

DESCRIPTION="A map application for GNOME"
HOMEPAGE="https://wiki.gnome.org/Apps/Maps"

LICENSE="GPL-2+ LGPL-2+ MIT CC-BY-3.0 CC-BY-SA-3.0"
SLOT="0"
IUSE=""
KEYWORDS="*"

RDEPEND="
	>=app-misc/geoclue-1.99.3:2.0
	>=dev-libs/gjs-1.42.0
	>=dev-libs/gobject-introspection-1.42.0
	>=dev-libs/glib-2.42.0:2
	media-libs/clutter-gtk:1.0[introspection]
	media-libs/clutter:1.0[introspection]
	media-libs/cogl:1.0[introspection]
	media-libs/libchamplain:0.12[introspection]
	net-libs/libsoup:2.4[introspection]
	sci-geosciences/geocode-glib[introspection]
	x11-libs/gdk-pixbuf:2[introspection]
	>=x11-libs/gtk+-3.14.0:3[introspection]
"

DEPEND="${RDEPEND}
	>=dev-util/intltool-0.40
	virtual/pkgconfig
"

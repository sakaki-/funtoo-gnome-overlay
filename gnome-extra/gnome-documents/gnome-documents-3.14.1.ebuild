# Distributed under the terms of the GNU General Public License v2

EAPI="5"
GCONF_DEBUG="no"

inherit gnome2

DESCRIPTION="A document manager application for GNOME"
HOMEPAGE="https://wiki.gnome.org/Apps/Documents"

LICENSE="GPL-2+"
SLOT="0"
IUSE=""
KEYWORDS="*"

# Need gdk-pixbuf-2.25 for gdk_pixbuf_get_pixels_with_length
COMMON_DEPEND="
	>=app-misc/tracker-1.2.0:=
	>=app-text/evince-3.14.0[introspection]
	dev-libs/gjs
	>=dev-libs/glib-2.42.0:2
	>=dev-libs/gobject-introspection-1.42.0
	>=dev-libs/libgdata-0.16.0[gnome,introspection]
	gnome-base/gnome-desktop:3=
	>=media-libs/clutter-1.20.0:1.0
	>=media-libs/clutter-gtk-1.6.0:1.0[introspection]
	>=net-libs/gnome-online-accounts-3.14.0
	>=net-libs/libsoup-2.48.0:2.4
	>=net-libs/libzapojit-0.0.2
	>=net-libs/webkit-gtk-1.10.0:3
	>=x11-libs/gdk-pixbuf-2.25:2[introspection]
	>=x11-libs/gtk+-3.14.0:3[introspection]
	x11-libs/pango[introspection]
"
RDEPEND="${COMMON_DEPEND}
	media-libs/clutter[introspection]
	net-misc/gnome-online-miners
	sys-apps/dbus
	x11-themes/gnome-icon-theme-symbolic
"
DEPEND="${COMMON_DEPEND}
	dev-libs/libxslt
	>=dev-util/intltool-0.50.1
	virtual/pkgconfig
"

src_configure() {
	gnome2_src_configure ITSTOOL="$(type -P true)"
}

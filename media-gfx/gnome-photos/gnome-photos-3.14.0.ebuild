# Distributed under the terms of the GNU General Public License v2

EAPI="5"
GCONF_DEBUG="no"

inherit gnome2

DESCRIPTION="Access, organize and share your photos on GNOME"
HOMEPAGE="https://wiki.gnome.org/Apps/Photos"

LICENSE="GPL-2+ LGPL-2+"
SLOT="0"
KEYWORDS="~*"
IUSE=""

RDEPEND="
	>=app-misc/tracker-1.2.0:=
	>=dev-libs/glib-2.42.0:2
	gnome-base/gnome-desktop:3=
	>=gnome-base/librsvg-2.40.0
	>=dev-libs/libgdata-0.15.2[gnome]
	media-libs/babl
	>=media-libs/gegl-0.2
	>=media-libs/grilo-0.2.11:0.2
	>=media-plugins/grilo-plugins-0.2.13:0.2[upnp-av]
	>=media-libs/exempi-1.99.5
	media-libs/lcms:2
	>=media-libs/libexif-0.6.14
	>=net-libs/gnome-online-accounts-3.14.0
	>=net-libs/libgfbgraph-0.2.1:0.2
	x11-libs/cairo
	x11-libs/gdk-pixbuf:2
	>=x11-libs/gtk+-3.14.0:3
"
DEPEND="${RDEPEND}
	dev-util/desktop-file-utils
	>=dev-util/intltool-0.50.1
	virtual/pkgconfig
"

# Requires dogtail
RESTRICT="test"

src_configure() {
	gnome2_src_configure ITSTOOL=$(type -P true)
}

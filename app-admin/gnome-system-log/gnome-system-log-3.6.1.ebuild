# Distributed under the terms of the GNU General Public License v2

EAPI="5"
GCONF_DEBUG="no"
GNOME2_LA_PUNT="yes"

inherit gnome2

DESCRIPTION="System log viewer for GNOME 3"
HOMEPAGE="https://live.gnome.org/GnomeUtils"

LICENSE="GPL-2+ CC-BY-SA-3.0"
SLOT="0"
IUSE=""
KEYWORDS="*"

COMMON_DEPEND=">=dev-libs/glib-2.31:2
	sys-libs/zlib:=
	>=x11-libs/gtk+-3.6:3
	x11-libs/pango"
RDEPEND="${COMMON_DEPEND}
	gnome-base/gsettings-desktop-schemas
	!<gnome-extra/gnome-utils-3.4"
# ${PN} was part of gnome-utils before 3.4
DEPEND="${COMMON_DEPEND}
	>=dev-util/intltool-0.40
	>=sys-devel/gettext-0.17
	virtual/pkgconfig"

src_configure() {
	G2CONF="${G2CONF}
		--enable-zlib
		ITSTOOL=$(type -P true)"
	gnome2_src_configure
}

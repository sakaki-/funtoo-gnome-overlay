# Distributed under the terms of the GNU General Public License v2

EAPI="5"
GCONF_DEBUG="no"
GNOME2_LA_PUNT="yes"

inherit eutils gnome2 virtualx

DESCRIPTION="Gtk module for bridging AT-SPI to Atk"
HOMEPAGE="http://live.gnome.org/Accessibility"

LICENSE="LGPL-2+"
SLOT="2"
KEYWORDS="~*"
IUSE=""

COMMON_DEPEND="
	>=app-accessibility/at-spi2-core-2.14.0
	>=dev-libs/atk-2.14.0
	>=dev-libs/glib-2.42.0:2
	>=sys-apps/dbus-1.5
"
RDEPEND="${COMMON_DEPEND}
	!<gnome-extra/at-spi-1.32.0-r1
"
DEPEND="${COMMON_DEPEND}
	virtual/pkgconfig
"

src_configure() {
	gnome2_src_configure --enable-p2p
}

src_test() {
	Xemake check
}

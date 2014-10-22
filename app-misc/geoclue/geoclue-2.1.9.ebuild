# Distributed under the terms of the GNU General Public License v2

EAPI="5"
GCONF_DEBUG="no"

inherit gnome2 systemd user versionator

MY_PV=$(get_version_component_range 1-2)
DESCRIPTION="A geoinformation D-Bus service"
HOMEPAGE="http://freedesktop.org/wiki/Software/GeoClue"
SRC_URI="http://www.freedesktop.org/software/${PN}/releases/${MY_PV}/${P}.tar.xz"

LICENSE="LGPL-2"
SLOT="2.0"
KEYWORDS="*"
IUSE="+modemmanager +networkmanager"

RDEPEND="
	>=dev-libs/glib-2.40.0:2
	>=dev-libs/json-glib-1.0.2
	>=dev-libs/libxml2-2.7:2
	net-libs/libsoup:2.4
	sys-apps/dbus
	modemmanager? ( >=net-misc/modemmanager-1 )
	networkmanager? ( >=net-misc/networkmanager-0.9.10.0 )
	!<sci-geosciences/geocode-glib-3.10.0
"
DEPEND="${RDEPEND}
	dev-util/gdbus-codegen
	>=dev-util/gtk-doc-am-1
	>=dev-util/intltool-0.40
	virtual/pkgconfig
"

RESTRICT="test"

src_configure() {
	# debug only affects CFLAGS
	gnome2_src_configure \
		--with-dbus-service-user=geoclue \
		$(use_enable modemmanager 3g-source) \
		$(use_enable modemmanager modem-gps-source) \
		$(use_enable networkmanager network-manager) \
		$(systemd_with_unitdir)
}

pkg_preinst() {
	enewgroup geoclue
	enewuser geoclue -1 -1 /var/lib/geoclue geoclue
}

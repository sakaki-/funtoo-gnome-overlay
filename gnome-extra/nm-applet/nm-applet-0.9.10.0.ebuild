# Distributed under the terms of the GNU General Public License v2

EAPI=5
GCONF_DEBUG="no"
GNOME2_LA_PUNT="yes"
GNOME_ORG_MODULE="network-manager-applet"

inherit gnome2

DESCRIPTION="GNOME applet for NetworkManager"
HOMEPAGE="https://wiki.gnome.org/Projects/NetworkManager"

LICENSE="GPL-2+"
SLOT="0"
IUSE="bluetooth gconf +introspection modemmanager"
KEYWORDS="*"

RDEPEND="
	app-crypt/libsecret
	>=dev-libs/glib-2.42.0:2
	>=dev-libs/dbus-glib-0.88
	>=sys-apps/dbus-1.4.1
	>=sys-auth/polkit-0.96-r1
	>=x11-libs/gtk+-3.14.0:3[introspection?]
	>=x11-libs/libnotify-0.7.0

	app-text/iso-codes
	>=net-misc/networkmanager-0.9.10.0[introspection?]
	net-misc/mobile-broadband-provider-info

	bluetooth? ( >=net-wireless/gnome-bluetooth-3.14.0:= )
	gconf? (
		>=gnome-base/gconf-2.20:2
		gnome-base/libgnome-keyring )
	introspection? ( >=dev-libs/gobject-introspection-1.42.0 )
	modemmanager? ( >=net-misc/modemmanager-1.4.0 )
	virtual/freedesktop-icon-theme
	virtual/libgudev:=
"
DEPEND="${RDEPEND}
	virtual/pkgconfig
	>=dev-util/intltool-0.40
"
PDEPEND="virtual/notification-daemon"
src_configure() {
	gnome2_src_configure \
		--disable-more-warnings \
		--disable-static \
		--localstatedir=/var \
		$(use_with bluetooth) \
		$(use_enable gconf migration) \
		$(use_enable introspection) \
		$(use_with modemmanager modem-manager-1)
}

# Distributed under the terms of the GNU General Public License v2

EAPI="5"
GCONF_DEBUG="no"
GNOME2_LA_PUNT="yes"

inherit gnome2 virtualx

DESCRIPTION="Network-related giomodules for glib"
HOMEPAGE="http://git.gnome.org/browse/glib-networking/"

LICENSE="LGPL-2+"
SLOT="0"
IUSE="+gnome +libproxy smartcard +ssl test"
KEYWORDS="*"

RDEPEND="
	>=dev-libs/glib-2.38:2
	gnome? ( gnome-base/gsettings-desktop-schemas )
	libproxy? ( >=net-libs/libproxy-0.4.6-r3:= )
	smartcard? (
		>=app-crypt/p11-kit-0.8
		>=net-libs/gnutls-2.12.8:=[pkcs11] )
	ssl? (
		app-misc/ca-certificates
		>=net-libs/gnutls-2.12.8:= )
"
DEPEND="${RDEPEND}
	>=dev-util/intltool-0.35.0
	sys-devel/gettext
	virtual/pkgconfig
	test? ( sys-apps/dbus[X] )
"
# eautoreconf needs >=sys-devel/autoconf-2.65:2.5

src_configure() {
	gnome2_src_configure \
		--disable-static \
		--with-ca-certificates="${EPREFIX}"/etc/ssl/certs/ca-certificates.crt \
		$(use_with gnome gnome-proxy) \
		$(use_with libproxy) \
		$(use_with smartcard pkcs11) \
		$(use_with ssl gnutls)
}

src_test() {
	Xemake check
}

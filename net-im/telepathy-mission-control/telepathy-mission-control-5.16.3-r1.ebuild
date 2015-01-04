# Distributed under the terms of the GNU General Public License v2

EAPI="5"
GCONF_DEBUG="no"
GNOME2_LA_PUNT="yes"
# Needed for tests and build #489466
PYTHON_COMPAT=( python2_{6,7} )

inherit autotools gnome2 python-any-r1

DESCRIPTION="An account manager and channel dispatcher for the Telepathy framework"
HOMEPAGE="http://cgit.freedesktop.org/telepathy/telepathy-mission-control/"
SRC_URI="http://telepathy.freedesktop.org/releases/${PN}/${P}.tar.gz"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="*"
IUSE="debug +deprecated networkmanager"

RDEPEND="
	>=dev-libs/dbus-glib-0.82
	>=dev-libs/glib-2.32:2
	>=sys-apps/dbus-0.95
	>=net-libs/telepathy-glib-0.20
	networkmanager? ( >=net-misc/networkmanager-0.7 )
	deprecated? ( >=sys-power/upower-0.99.0:=[deprecated] )
"
DEPEND="${RDEPEND}
	${PYTHON_DEPS}
	dev-libs/libxslt
	>=dev-util/gtk-doc-am-1.17
	virtual/pkgconfig
"

# Tests are broken, see upstream bug #29334 and #64212
# upstream doesn't want it enabled everywhere (#29334#c12)
RESTRICT="test"

src_prepare() {
	if use deprecated; then
		# From Funtoo:
		# 	https://bugs.funtoo.org/browse/FL-1329
		epatch "${FILESDIR}"/${P}-restore-deprecated-code.patch
	fi

	epatch_user

	eautoreconf
	gnome2_src_prepare
}

src_configure() {
	gnome2_src_configure \
		 --disable-static \
		$(use_enable debug) \
		$(use_enable deprecated) \
		$(use_with networkmanager connectivity nm)
}

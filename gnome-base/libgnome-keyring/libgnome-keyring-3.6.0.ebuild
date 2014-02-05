# Distributed under the terms of the GNU General Public License v2

EAPI="5"
GCONF_DEBUG="yes"
GNOME2_LA_PUNT="yes"
VALA_MIN_API_VERSION="0.16"
VALA_USE_DEPEND="vapigen"

inherit gnome2 python vala

DESCRIPTION="Compatibility library for accessing secrets"
HOMEPAGE="http://live.gnome.org/GnomeKeyring"

LICENSE="LGPL-2+ GPL-2+" # tests are GPL-2
SLOT="0"
KEYWORDS="*"
IUSE="debug +introspection test vala"
REQUIRED_USE="vala? ( introspection )"

RDEPEND=">=sys-apps/dbus-1.0
	>=gnome-base/gnome-keyring-3.1.92
	introspection? ( >=dev-libs/gobject-introspection-1.30.0 )"
DEPEND="${RDEPEND}
	dev-util/gtk-doc-am
	>=dev-util/intltool-0.35
	sys-devel/gettext
	virtual/pkgconfig
	test? ( =dev-lang/python-2* )
	vala? ( $(vala_depend) )"

pkg_setup() {
	if use test; then
		python_set_active_version 2
		python_pkg_setup
	fi
}

src_prepare() {
	G2CONF="${G2CONF} $(use_enable vala)"
	use vala && vala_src_prepare
	gnome2_src_prepare

	# FIXME: Remove silly CFLAGS
	sed -e 's:CFLAGS="$CFLAGS -g:CFLAGS="$CFLAGS:' \
		-e 's:CFLAGS="$CFLAGS -O0:CFLAGS="$CFLAGS:' \
		-i configure.ac configure || die "sed failed"
}

src_test() {
	unset DBUS_SESSION_BUS_ADDRESS
	dbus-launch emake check || die "tests failed"
}

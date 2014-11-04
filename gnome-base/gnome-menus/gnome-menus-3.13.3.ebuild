# Distributed under the terms of the GNU General Public License v2

EAPI="5"
GCONF_DEBUG="no"

inherit eutils gnome2

DESCRIPTION="Library for the Desktop Menu fd.o specification"
HOMEPAGE="https://git.gnome.org/browse/gnome-menus"

LICENSE="GPL-2+ LGPL-2+"
SLOT="3"
KEYWORDS="*"

IUSE="debug +introspection test"

COMMON_DEPEND="
	>=dev-libs/glib-2.42.0:2
	introspection? ( >=dev-libs/gobject-introspection-1.42.0 )
"
# Older versions of slot 0 install the menu editor and the desktop directories

RDEPEND="${COMMON_DEPEND}
	!<gnome-base/gnome-menus-3.0.1-r1:0
"
DEPEND="${COMMON_DEPEND}
	>=dev-util/intltool-0.40
	sys-devel/gettext
	virtual/pkgconfig
	test? ( dev-libs/gjs )
"

src_prepare() {
	# Don't show KDE standalone settings desktop files in GNOME others menu
	epatch "${FILESDIR}/${PN}-3.8.0-ignore_kde_standalone.patch"

	gnome2_src_prepare
}

src_configure() {
	DOCS="AUTHORS ChangeLog HACKING NEWS README"

	# Do NOT compile with --disable-debug/--enable-debug=no
	# It disables api usage checks
	gnome2_src_configure \
		$(usex debug --enable-debug=yes --enable-debug=minimum) \
		$(use_enable introspection) \
		--disable-static
}

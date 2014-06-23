# Distributed under the terms of the GNU General Public License v2

EAPI="5"

GNOME2_LA_PUNT="yes"
inherit gnome2 multilib-minimal

DESCRIPTION="GL extensions for Gtk+ 2.0"
HOMEPAGE="http://gtkglext.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.bz2"

LICENSE="GPL-2 LGPL-2.1"
SLOT="0"
KEYWORDS="*"
IUSE=""

RDEPEND="dev-libs/glib:2[${MULTILIB_USEDEP}]
	>=x11-libs/gtk+-2.24.23:2[${MULTILIB_USEDEP}]
	>=x11-libs/pango-1.36.3[X,${MULTILIB_USEDEP}]
	|| (
		>=x11-libs/pangox-compat-0.0.2[${MULTILIB_USEDEP}]
		<x11-libs/pango-1.31[X,${MULTILIB_USEDEP}]
	)
	>=x11-libs/libX11-1.6.2[${MULTILIB_USEDEP}]
	>=x11-libs/libXmu-1.1.1-r1[${MULTILIB_USEDEP}]
	>=virtual/glu-9.0-r1[${MULTILIB_USEDEP}]
	>=virtual/opengl-7.0-r1[${MULTILIB_USEDEP}]"
DEPEND="${RDEPEND}
	>=virtual/pkgconfig-0-r1[${MULTILIB_USEDEP}]"

src_prepare() {
	gnome2_src_prepare

	# Remove development knobs, bug #308973
	sed -i 's:-D\(G.*DISABLE_DEPRECATED\):-D__\1__:g' \
		examples/Makefile.am examples/Makefile.in \
		gdk/Makefile.am gdk/Makefile.in \
		gdk/win32/Makefile.am gdk/win32/Makefile.in \
		gdk/x11/Makefile.am gdk/x11/Makefile.in \
		gtk/Makefile.am gtk/Makefile.in \
		|| die "sed failed"
}

multilib_src_configure() {
	ECONF_SOURCE=${S} \
	gnome2_src_configure \
		--disable-static
}

multilib_src_install() {
	gnome2_src_install
}

multilib_src_install_all() {
	local DOCS="AUTHORS ChangeLog* NEWS README TODO"
	einstalldocs
}

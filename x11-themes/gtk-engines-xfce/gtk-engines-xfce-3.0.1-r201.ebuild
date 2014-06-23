# Distributed under the terms of the GNU General Public License v2

EAPI=5
MY_PN=gtk-xfce-engine
inherit xfconf multilib-minimal

DESCRIPTION="A port of Xfce engine to GTK+ 2.x"
HOMEPAGE="http://www.xfce.org/projects/"
SRC_URI="mirror://xfce/src/xfce/${MY_PN}/${PV%.*}/${MY_PN}-${PV}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="*"
IUSE="debug"

RDEPEND=">=dev-libs/glib-2.38.2-r1[${MULTILIB_USEDEP}]
	>=x11-libs/gtk+-2.24.23:2[${MULTILIB_USEDEP}]
	abi_x86_32? (
		!<=app-emulation/emul-linux-x86-gtklibs-20140508
		!app-emulation/emul-linux-x86-gtklibs[-abi_x86_32(-)]
	)"
DEPEND="${RDEPEND}
	virtual/pkgconfig"

S=${WORKDIR}/${MY_PN}-${PV}

pkg_setup() {
	XFCONF=(
		--disable-gtk3
		$(xfconf_use_debug)
		)

	DOCS=( AUTHORS ChangeLog NEWS README )
}

multilib_src_configure() {
	ECONF_SOURCE=${S} \
		xfconf_src_configure
}

multilib_src_install_all() {
	einstalldocs
	prune_libtool_files --all
}

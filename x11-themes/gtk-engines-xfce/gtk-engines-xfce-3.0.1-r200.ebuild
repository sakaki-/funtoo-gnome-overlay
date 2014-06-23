# Distributed under the terms of the GNU General Public License v2

EAPI=5
MY_PN=gtk-xfce-engine
inherit xfconf

DESCRIPTION="A port of Xfce engine to GTK+ 2.x"
HOMEPAGE="http://www.xfce.org/projects/"
SRC_URI="mirror://xfce/src/xfce/${MY_PN}/${PV%.*}/${MY_PN}-${PV}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="*"
IUSE="debug"

RDEPEND=">=dev-libs/glib-2.24
	>=x11-libs/gtk+-2.20:2"
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

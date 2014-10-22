# Distributed under the terms of the GNU General Public License v2

EAPI="5"
GCONF_DEBUG="no"

inherit gnome2-live

DESCRIPTION="System log viewer for GNOME"
HOMEPAGE="https://live.gnome.org/GnomeUtils"
EGIT_COMMIT="3526bf637370fd56e909f1a0d502420af53c7fcf"

LICENSE="GPL-2+ CC-BY-SA-3.0"
SLOT="0"
IUSE=""
KEYWORDS="*"

COMMON_DEPEND="
	>=dev-libs/glib-2.31:2
	sys-libs/zlib:=
	>=x11-libs/gtk+-3.9.11:3
	x11-libs/pango
"
RDEPEND="${COMMON_DEPEND}
	gnome-base/gsettings-desktop-schemas
	!<gnome-extra/gnome-utils-3.4"
# ${PN} was part of gnome-utils before 3.4

DEPEND="${COMMON_DEPEND}
	>=dev-util/intltool-0.40
	>=sys-devel/gettext-0.17
	virtual/pkgconfig
"

src_prepare() {
	if [[ ! -e configure ]] ; then
		./autogen.sh || die

		cd help; make clean; make || die; cd ..
	fi

	epatch "${FILESDIR}"/${P}-update-version-information.patch

	gnome2_src_prepare
}

src_configure() {
	gnome2_src_configure \
		--enable-zlib \
		ITSTOOL=$(type -P true)
}

pkg_postinst() {
	ewarn "While this ebuild is tied to a specific git commit, instability can still occur"
}

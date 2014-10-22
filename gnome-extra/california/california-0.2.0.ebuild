# Distributed under the terms of the GNU General Public License v2

EAPI="5"

VALA_MIN_API_VERSION="0.24"

inherit eutils autotools gnome2 vala

DESCRIPTION="Calendar application for GNOME 3"
HOMEPAGE="http://wiki.gnome.org/Apps/California"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~*"
IUSE=""

RDEPEND="
	>=dev-libs/glib-2.42.0:2
	>=dev-libs/gobject-introspection-1.42.0
	>=dev-libs/libgdata-0.16.0
	>=dev-libs/libgee-0.16.0:0.8
	>=net-libs/gnome-online-accounts-3.14.0:0/1
	>=net-libs/libsoup-2.48.0:2.4
	>=x11-libs/gtk+-3.14.0:3"
DEPEND="${RDEPEND}
	$(vala_depend)
	>=dev-util/intltool-0.35.0"

DOCS=( ChangeLog README  COPYING AUTHORS INSTALL NEWS )

src_prepare() {
	epatch "${FILESDIR}"/0.1.2-fix-docdir.patch
	eautoreconf
}

src_compile() {
	local valaver="$(vala_best_api_version)"
	emake VALAC="$(type -p valac-${valaver})"
}

src_install() {
	gnome2_src_install
}

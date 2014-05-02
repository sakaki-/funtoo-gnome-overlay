# Distributed under the terms of the GNU General Public License v2

EAPI="5"
GCONF_DEBUG="no"

inherit gnome2

DESCRIPTION="Symbolic icons for GNOME default icon theme"
HOMEPAGE="http://www.gnome.org/"

LICENSE="CC-BY-SA-3.0"
SLOT="0"
IUSE=""
KEYWORDS="*"

COMMON_DEPEND=">=x11-themes/hicolor-icon-theme-0.10"
RDEPEND="${COMMON_DEPEND}
	!=gnome-extra/gnome-power-manager-3.0*
	!=gnome-extra/gnome-power-manager-3.1*"
# keyboard-brightness icon file collision with old gnome-power-manager
DEPEND="${COMMON_DEPEND}
	>=x11-misc/icon-naming-utils-0.8.7
	virtual/pkgconfig"

# This ebuild does not install any binaries
RESTRICT="binchecks strip"

# FIXME: double check potential LINGUAS problem
src_prepare() {
	DOCS="AUTHORS NEWS README"
	G2CONF="${G2CONF}
		--enable-icon-mapping
		GTK_UPDATE_ICON_CACHE=$(type -P true)"
}

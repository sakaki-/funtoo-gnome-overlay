# Distributed under the terms of the GNU General Public License v2

EAPI="5"
GCONF_DEBUG="no"

inherit gnome2

DESCRIPTION="Mouse accessibility enhancements for the GNOME desktop"
HOMEPAGE="http://live.gnome.org/Mousetweaks/Home"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="*"
IUSE=""

RDEPEND="
	>=dev-libs/glib-2.40.0:2
	>=x11-libs/gtk+-3.12.0:3
	>=gnome-base/gsettings-desktop-schemas-3.12.0

	x11-libs/libX11
	x11-libs/libXtst
	x11-libs/libXfixes
	x11-libs/libXcursor
"
DEPEND="${RDEPEND}
	>=dev-util/intltool-0.40
	virtual/pkgconfig
"

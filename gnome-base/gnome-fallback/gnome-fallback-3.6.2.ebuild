# Distributed under the terms of the GNU General Public License v2

EAPI="5"

DESCRIPTION="Sub-meta package for GNOME 3 fallback mode"
HOMEPAGE="http://www.gnome.org/"
LICENSE="metapackage"
SLOT="3.0"
IUSE="cups"

# when unmasking for an arch
# double check none of the deps are still masked !
KEYWORDS="*"

# Note to developers:
# This is a wrapper for the GNOME 3 fallback apps list
RDEPEND="
	>=gnome-base/gnome-core-libs-${PV}[cups?]

	>=x11-wm/metacity-2.34.13
	>=x11-misc/notification-daemon-0.7.6
	>=gnome-extra/polkit-gnome-0.105
	>=gnome-base/gnome-panel-${PV}
"
DEPEND=""

S="${WORKDIR}"

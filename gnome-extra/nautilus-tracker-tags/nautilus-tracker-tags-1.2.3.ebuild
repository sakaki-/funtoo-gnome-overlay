# Distributed under the terms of the GNU General Public License v2

EAPI="5"
GNOME_ORG_MODULE="tracker"

inherit gnome.org toolchain-funcs

DESCRIPTION="Nautilus extension to tag files for Tracker"
HOMEPAGE="https://wiki.gnome.org/Projects/Tracker"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~*"
IUSE=""

COMMON_DEPEND="
	~app-misc/tracker-${PV}
	>=dev-libs/glib-2.42.0:2
	>=gnome-base/nautilus-3.14.0
	x11-libs/gtk+:3
"
RDEPEND="${COMMON_DEPEND}
	!<app-misc/tracker-0.12.5-r1[nautilus]
"
# Before tracker-0.12.5-r1, nautilus-tracker-tags was part of tracker
DEPEND="${COMMON_DEPEND}"

S="${S}/src/plugins/nautilus"

pkg_setup() {
	tc-export CC
	export TRACKER_API=${GNOME_ORG_PVP}
}

src_prepare() {
	sed -e 's:#include "config.h"::' -i *.c *.h || die "sed failed"
}

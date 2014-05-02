# Distributed under the terms of the GNU General Public License v2

EAPI="3"
GNOME_ORG_MODULE="vte"
GNOME_TARBALL_SUFFIX="xz"

inherit gnome.org base

DESCRIPTION="GNOME Setuid helper for opening ptys"
HOMEPAGE="http://git.gnome.org/browse/vte/"
# gnome-pty-helper is inside vte

LICENSE="LGPL-2"
SLOT="0"
KEYWORDS="*"
IUSE=""

# gnome-pty-helper was spit out with 0.27.90
RDEPEND="!<x11-libs/vte-0.27.90"
DEPEND=""

S="${WORKDIR}/vte-${PV}/gnome-pty-helper"

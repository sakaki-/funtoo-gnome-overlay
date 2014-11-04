# Distributed under the terms of the GNU General Public License v2

EAPI="5"

inherit gnome.org

DESCRIPTION="Common files for development of Gnome packages"
HOMEPAGE="http://git.gnome.org/browse/gnome-common"

LICENSE="GPL-3"
SLOT="3"
KEYWORDS="*"
IUSE=""

src_install() {
	default
	mv doc-build/README README.doc-build || die "renaming doc-build/README failed"
	dodoc ChangeLog README*
}

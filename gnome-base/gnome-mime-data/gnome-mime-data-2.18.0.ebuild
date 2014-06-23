# Distributed under the terms of the GNU General Public License v2

inherit gnome2

DESCRIPTION="MIME data for Gnome"
HOMEPAGE="http://www.gnome.org/"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="alpha amd64 arm hppa ia64 ~mips ppc ppc64 sh sparc x86 ~amd64-fbsd ~x86-fbsd ~x86-interix ~amd64-linux ~x86-linux ~ppc-macos ~x86-macos ~sparc-solaris ~x64-solaris ~x86-solaris"
IUSE=""

RDEPEND=""
DEPEND="virtual/pkgconfig
		>=dev-util/intltool-0.35"

DOCS="AUTHORS ChangeLog README"

src_unpack() {
	gnome2_src_unpack

	intltoolize --force || die "intltoolize failed"
}

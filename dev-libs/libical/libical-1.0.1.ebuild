# Distributed under the terms of the GNU General Public License v2

EAPI=5
inherit cmake-utils

DESCRIPTION="An implementation of basic iCAL protocols from citadel, previously known as aurore"
HOMEPAGE="http://freeassociation.sourceforge.net"
SRC_URI="https://github.com/${PN}/${PN}/archive/v${PV}.tar.gz"

LICENSE="|| ( MPL-1.1 LGPL-2 )"
SLOT="0/1"
KEYWORDS="*"
IUSE="doc examples introspection static-libs"

RDEPEND="introspection? ( dev-libs/gobject-introspection )"
DEPEND="${RDEPEND}
	dev-lang/perl"

src_prepare() {
	cmake-utils_src_prepare
}

src_configure() {
	local mycmakeargs=" $( cmake-utils_use introspection GOBJECT_INTROSPECTION )"
	cmake-utils_src_configure
}

DOCS=(
	AUTHORS TEST THANKS TODO
	doc/{AddingOrModifyingComponents,UsingLibical}.txt
)

src_compile() {
	cmake-utils_src_compile -j1
}

src_install() {
	cmake-utils_src_install

	# Remove static libs, cmake-flag is a trap.
	use static-libs || find "${ED}" -name '*.a' -delete

	if use examples; then
		rm examples/Makefile* examples/CMakeLists.txt
		insinto /usr/share/doc/${PF}/examples
		doins examples/*
	fi
}

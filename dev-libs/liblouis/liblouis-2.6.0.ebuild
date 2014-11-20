# Distributed under the terms of the GNU General Public License v2

EAPI="5-progress"
PYTHON_DEPEND="python? ( <<[wide-unicode(+)]>> )"
PYTHON_ABI_TYPE="multiple"
PYTHON_RESTRICTED_ABIS="*-jython *-pypy"

inherit distutils

DESCRIPTION="An open-source braille translator, back-translator and formatter"
HOMEPAGE="http://www.liblouis.org/ https://github.com/liblouis/liblouis"
SRC_URI="https://github.com/liblouis/liblouis/releases/download/v${PV}/${P}.tar.gz"

LICENSE="LGPL-3"
SLOT="0"
KEYWORDS="*"
IUSE="python"

DEPEND=""
RDEPEND=""

DISTUTILS_SETUP_FILES=("python|setup.py")
PYTHON_MODULES="louis"

pkg_setup() {
	if use python; then
		python_pkg_setup
	fi
}

src_prepare() {
	default

	if use python; then
		distutils_src_prepare
	fi
}

src_configure() {
	econf --enable-ucs4
}

src_compile() {
	default

	if use python; then
		LD_LIBRARY_PATH="${S}/liblouis/.libs" distutils_src_compile
	fi
}

src_install() {
	DOCS="AUTHORS ChangeLog NEWS README" default
	dohtml doc/liblouis.html

	if use python; then
		LD_LIBRARY_PATH="${S}/liblouis/.libs" distutils_src_install
	fi
}

pkg_postinst() {
	if use python; then
		distutils_pkg_postinst
	fi
}

pkg_postrm() {
	if use python; then
		distutils_pkg_postrm
	fi
}

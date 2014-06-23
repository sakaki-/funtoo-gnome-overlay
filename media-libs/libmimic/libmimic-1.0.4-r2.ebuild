# Distributed under the terms of the GNU General Public License v2

EAPI="5"

inherit multilib-minimal

DESCRIPTION="Video encoding/decoding library for the codec used by msn"
HOMEPAGE="http://farsight.sourceforge.net/"
SRC_URI="mirror://sourceforge/farsight/${P}.tar.gz"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="*"
IUSE="doc static-libs"

RDEPEND="dev-libs/glib:2[${MULTILIB_USEDEP}]
	abi_x86_32? ( !<=app-emulation/emul-linux-x86-medialibs-20130224-r8
		!app-emulation/emul-linux-x86-medialibs[-abi_x86_32(-)] )"
DEPEND="${RDEPEND}
	virtual/pkgconfig
	doc? ( app-doc/doxygen )"

DOCS=( AUTHORS ChangeLog NEWS README )

multilib_src_configure() {
	local myconf="--disable-doxygen-docs"
	multilib_is_native_abi && myconf="$(use_enable doc doxygen-docs)"

	ECONF_SOURCE="${S}" econf \
		$(use_enable static-libs static) \
		${myconf}
}

multilib_src_install() {
	emake DESTDIR="${D}" install

	if use doc && multilib_is_native_abi; then
		dohtml doc/api/html/*
	fi
}

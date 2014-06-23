# Distributed under the terms of the GNU General Public License v2

EAPI="5"

GST_ORG_MODULE="gst-plugins-bad"
inherit eutils flag-o-matic gstreamer

DESCRIPTION="Less plugins for GStreamer"
HOMEPAGE="http://gstreamer.freedesktop.org/"
SRC_URI+=" http://dev.gentoo.org/~tetromino/distfiles/${PN}/${P}-h264-patches.tar.xz"

LICENSE="LGPL-2"
KEYWORDS="*"
IUSE="+orc"

RDEPEND="
	dev-libs/glib:2[${MULTILIB_USEDEP}]
	>=media-libs/gst-plugins-base-0.10.36:${SLOT}[${MULTILIB_USEDEP}]
	>=media-libs/gstreamer-0.10.36:${SLOT}[${MULTILIB_USEDEP}]
	orc? ( >=dev-lang/orc-0.4.17[${MULTILIB_USEDEP}] )
"
DEPEND="${RDEPEND}"
RDEPEND="${RDEPEND}
	!<media-plugins/gst-plugins-farsight-0.12.11:${SLOT}"

src_prepare() {
	# Patches from 0.10 branch fixing h264 baseline decoding; bug #446384
	epatch "${WORKDIR}/${P}-h264-patches"/*.patch
}

src_configure() {
	strip-flags
	replace-flags "-O3" "-O2"
	filter-flags "-fprefetch-loop-arrays" # (Bug #22249)

	multilib-minimal_src_configure
}

multilib_src_configure() {
	gstreamer_multilib_src_configure \
		$(use_enable orc) \
		--disable-examples \
		--disable-debug
}

multilib_src_install_all() {
	DOCS="AUTHORS ChangeLog NEWS README RELEASE"
	einstalldocs
	prune_libtool_files --modules
}

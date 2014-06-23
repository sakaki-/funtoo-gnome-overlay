# Distributed under the terms of the GNU General Public License v2

EAPI="5"

GST_ORG_MODULE="gst-plugins-bad"
inherit eutils flag-o-matic gstreamer

DESCRIPTION="Less plugins for GStreamer"
HOMEPAGE="http://gstreamer.freedesktop.org/"

LICENSE="LGPL-2"
KEYWORDS="*"
IUSE="egl +introspection +orc vnc"

# FIXME: we need to depend on mesa to avoid automagic on egl
# dtmf plugin moved from bad to good in 1.2
# X11 is automagic for now, upstream #709530
RDEPEND="
	dev-libs/glib:2[${MULTILIB_USEDEP}]
	>=media-libs/gst-plugins-base-1.2:${SLOT}[${MULTILIB_USEDEP}]
	>=media-libs/gstreamer-1.2:${SLOT}[${MULTILIB_USEDEP}]
	egl? ( >=media-libs/mesa-9.1.6[egl,${MULTILIB_USEDEP}] )
	introspection? ( >=dev-libs/gobject-introspection-1.31.1 )
	orc? ( >=dev-lang/orc-0.4.17[${MULTILIB_USEDEP}] )

	!<media-libs/gst-plugins-good-1.1:${SLOT}
"
DEPEND="${RDEPEND}
	>=dev-util/gtk-doc-am-1.12
"

src_configure() {
	strip-flags
	replace-flags "-O3" "-O2"
	filter-flags "-fprefetch-loop-arrays" # (Bug #22249)

	multilib-minimal_src_configure
}

multilib_src_configure() {
	gstreamer_multilib_src_configure \
		$(multilib_native_use_enable introspection) \
		$(use_enable orc) \
		$(use_enable vnc librfb) \
		--disable-examples \
		--disable-debug \
		--with-egl-window-system=$(usex egl x11 none)
}

multilib_src_install_all() {
	DOCS="AUTHORS ChangeLog NEWS README RELEASE"
	einstalldocs
	prune_libtool_files --modules
}

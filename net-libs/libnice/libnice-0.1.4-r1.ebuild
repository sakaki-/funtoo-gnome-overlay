# Distributed under the terms of the GNU General Public License v2

EAPI=5
inherit eutils multilib-minimal

DESCRIPTION="An implementation of the Interactice Connectivity Establishment standard (ICE)"
HOMEPAGE="http://nice.freedesktop.org/wiki/"
SRC_URI="http://nice.freedesktop.org/releases/${P}.tar.gz"

LICENSE="|| ( MPL-1.1 LGPL-2.1 )"
SLOT="0"
KEYWORDS="*"
IUSE="+upnp"

RDEPEND="dev-libs/glib:2[${MULTILIB_USEDEP}]
	upnp? ( >=net-libs/gupnp-igd-0.2.2-r1:=[${MULTILIB_USEDEP}] )"
DEPEND="${RDEPEND}
	dev-util/gtk-doc-am
	>=virtual/pkgconfig-0-r1[${MULTILIB_USEDEP}]"

multilib_src_configure() {
	# gstreamer plugin split off into media-plugins/gst-plugins-libnice
	ECONF_SOURCE=${S} \
	econf --disable-static \
		--without-gstreamer \
		--without-gstreamer-0.10 \
		$(use_enable upnp gupnp)

	if multilib_is_native_abi; then
		ln -s {"${S}"/,}docs/reference/libnice/html || die
	fi
}

multilib_src_install_all() {
	einstalldocs
	prune_libtool_files --modules
}

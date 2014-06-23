# Distributed under the terms of the GNU General Public License v2

EAPI=5
inherit eutils

DESCRIPTION="An implementation of the Interactice Connectivity Establishment standard (ICE)"
HOMEPAGE="http://nice.freedesktop.org/wiki/"
SRC_URI="http://nice.freedesktop.org/releases/${P}.tar.gz"

LICENSE="|| ( MPL-1.1 LGPL-2.1 )"
SLOT="0"
KEYWORDS="*"
IUSE="+upnp"

RDEPEND=">=dev-libs/glib-2.13:2
	upnp? ( >=net-libs/gupnp-igd-0.1.3:= )"
DEPEND="${RDEPEND}
	dev-util/gtk-doc-am
	virtual/pkgconfig"

src_configure() {
	# gstreamer plugin split off into media-plugins/gst-plugins-libnice
	econf --disable-static \
		--without-gstreamer \
		--without-gstreamer-0.10 \
		$(use_enable upnp gupnp)
}

src_install() {
	default
	prune_libtool_files --modules
}

# Distributed under the terms of the GNU General Public License v2

EAPI="5"

GST_ORG_MODULE=gst-plugins-base
inherit gstreamer

KEYWORDS="*"
IUSE=""

RDEPEND="dev-libs/glib:2[${MULTILIB_USEDEP}]"
DEPEND="${RDEPEND}"

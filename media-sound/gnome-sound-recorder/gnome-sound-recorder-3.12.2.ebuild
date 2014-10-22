# Distributed under the terms of the GNU General Public License v2

EAPI="5"

inherit autotools gnome2

DESCRIPTION="Gnome Sound Recorder"
HOMEPAGE="https://wiki.gnome.org/ThreePointEleven/Features/SoundRecorder"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="*"

RDEPEND="
	>=x11-libs/gtk+-3.12.0:3
	dev-libs/gjs
	media-libs/gstreamer:1.0
	media-libs/gst-plugins-bad:1.0
"
DEPEND="${COMMON_DEPEND}
"

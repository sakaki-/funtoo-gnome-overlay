# Distributed under the terms of the GNU General Public License v2

EAPI="5"

DESCRIPTION="Sub-meta package for the applications of GNOME 3"
HOMEPAGE="http://www.gnome.org/"
LICENSE="metapackage"
SLOT="3.0"
IUSE="+epiphany +evolution +games +shotwell +tracker"

KEYWORDS="*"

RDEPEND="
	>=gnome-base/gnome-core-libs-${PV}

	>=app-admin/gnome-system-log-3.9.90
	>=app-arch/file-roller-${PV}
	>=app-dicts/gnome-dictionary-3.14.0
	>=app-misc/bijiben-3.14.0
	>=gnome-extra/california-0.2.0
	>=gnome-extra/gconf-editor-3
	>=gnome-extra/gnome-calculator-3.14.0
	>=gnome-extra/gnome-clocks-3.14.0
	>=gnome-extra/gnome-getting-started-docs-3.14.0
	>=gnome-extra/gnome-power-manager-3.14.0
	>=gnome-extra/gnome-system-monitor-${PV}
	>=gnome-extra/gnome-search-tool-3.6.0
	>=gnome-extra/gnome-tweak-tool-3.14.0
	>=gnome-extra/gnome-weather-3.14.0
	>=gnome-extra/gucharmap-${PV}
	>=gnome-extra/nautilus-sendto-3.8.0
	>=gnome-extra/sushi-3.12.0
	>=mail-client/geary-0.8.1
	>=media-gfx/gnome-font-viewer-3.14.0
	>=media-gfx/gnome-photos-3.14.0
	>=media-gfx/gnome-screenshot-3.14.0
	>=media-sound/gnome-music-3.14.0
	>=media-sound/gnome-sound-recorder-3.14.0
	>=media-sound/sound-juicer-3.14.0
	>=media-video/cheese-${PV}
	>=net-analyzer/gnome-nettool-3.8.0
	>=net-misc/vinagre-${PV}
	>=net-misc/vino-3.14.0
	>=sci-geosciences/gnome-maps-3.14.0
	>=sys-apps/baobab-${PV}
	>=sys-apps/gnome-disk-utility-3.12.0

	epiphany? ( >=www-client/epiphany-${PV} )
	evolution? ( >=mail-client/evolution-3.12.7 )
	games? (
		>=games-arcade/gnome-nibbles-${PV}
		>=games-arcade/gnome-robots-${PV}
		>=games-board/aisleriot-${PV}
		>=games-board/four-in-a-row-${PV}
		>=games-board/gnome-chess-3.14.0
		>=games-board/gnome-mahjongg-${PV}
		>=games-board/gnome-mines-${PV}
		>=games-board/iagno-${PV}
		>=games-board/tali-3.14.0
		>=games-puzzle/five-or-more-${PV}
		>=games-puzzle/gnome-klotski-${PV}
		>=games-puzzle/gnome-sudoku-${PV}
		>=games-puzzle/gnome-tetravex-3.14.0
		>=games-puzzle/lightsoff-${PV}
		>=games-puzzle/quadrapassel-3.14.0
		>=games-puzzle/swell-foop-3.14.0 )
	shotwell? ( >=media-gfx/shotwell-0.20.0 )
	tracker? (
		>=app-misc/tracker-1
		>=gnome-extra/gnome-documents-3.14.0 )

	amd64? ( >=gnome-extra/gnome-user-share-3.14.0 )
	x86? ( >=gnome-extra/gnome-user-share-3.14.0 )
"

DEPEND=""

S=${WORKDIR}

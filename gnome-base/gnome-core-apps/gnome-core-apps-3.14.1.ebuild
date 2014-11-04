# Distributed under the terms of the GNU General Public License v2

EAPI="5"

DESCRIPTION="Sub-meta package for the core applications integrated with GNOME 3"
HOMEPAGE="http://www.gnome.org/"
LICENSE="metapackage"
SLOT="3.0"
IUSE="+bluetooth +cdr cups"

# when unmasking for an arch
# double check none of the deps are still masked !
KEYWORDS="*"

# Note to developers:
# This is a wrapper for the core apps tightly integrated with GNOME 3
# gtk-engines:2 is still around because it's needed for gtk2 apps
RDEPEND="
	>=gnome-base/gnome-core-libs-${PV}[cups?]

	>=gnome-base/gnome-session-3.14.0
	>=gnome-base/gnome-menus-3.13.3:3
	>=gnome-base/gnome-settings-daemon-${PV}[cups?]
	>=gnome-base/gnome-control-center-${PV}[cups?]

	>=app-crypt/gcr-3.14.0
	>=gnome-base/nautilus-3.14.0
	>=gnome-base/gnome-keyring-3.14.0
	>=gnome-extra/evolution-data-server-3.12.7

	>=app-crypt/seahorse-3.14.0
	>=app-editors/gedit-3.14.0
	>=app-text/evince-${PV}
	>=gnome-extra/gnome-contacts-${PV}
	>=media-gfx/eog-${PV}
	>=media-video/totem-3.14.0
	>=net-im/empathy-3.12.7
	>=x11-terms/gnome-terminal-${PV}

	>=gnome-extra/gnome-user-docs-${PV}
	>=gnome-extra/yelp-${PV}

	>=x11-themes/gtk-engines-2.20.2:2
	>=x11-themes/adwaita-icon-theme-3.14.0
	>=x11-themes/gnome-themes-standard-3.14.0

	bluetooth? ( >=net-wireless/gnome-bluetooth-3.14.0 )
	cdr? ( >=app-cdr/brasero-3.11.4 )

	!gnome-base/gnome-applets
"
DEPEND=""

S="${WORKDIR}"

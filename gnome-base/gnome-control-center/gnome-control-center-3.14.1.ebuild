# Distributed under the terms of the GNU General Public License v2

EAPI="5"
GCONF_DEBUG="yes"
GNOME2_LA_PUNT="yes" # gmodule is used, which uses dlopen

inherit autotools bash-completion-r1 eutils gnome2

DESCRIPTION="GNOME's main interface to configure various aspects of the desktop"
HOMEPAGE="https://git.gnome.org/browse/gnome-control-center/"

LICENSE="GPL-2+"
SLOT="2"
IUSE="+bluetooth +colord +cups deprecated +gnome-online-accounts +i18n input_devices_wacom kerberos v4l"
KEYWORDS="~*"

# False positives caused by nested configure scripts
QA_CONFIGURE_OPTIONS=".*"

# gnome-session-2.91.6-r1 is needed so that 10-user-dirs-update is run at login
# g-s-d[policykit] needed for bug #403527
#
# kerberos unfortunately means mit-krb5; build fails with heimdal

# FIXME: modemmanager is not optional
#        networkmanager is not optional

COMMON_DEPEND="
	>=dev-libs/glib-2.42.0:2
	>=x11-libs/gdk-pixbuf-2.23.0:2
	>=x11-libs/gtk+-3.14.0:3
	>=gnome-base/gsettings-desktop-schemas-3.14.0
	>=gnome-base/gnome-desktop-3.14.0:3=
	>=gnome-base/gnome-settings-daemon-3.14.0[colord?,policykit]

	>=dev-libs/libpwquality-1.2.2
	dev-libs/libxml2:2
	gnome-base/libgtop:2=
	media-libs/fontconfig

	>=media-libs/libcanberra-0.13[gtk3]
	>=media-sound/pulseaudio-2[glib]
	>=sys-auth/polkit-0.97
	>=sys-power/upower-0.99
	>=x11-libs/libnotify-0.7.6:0=

	>=gnome-extra/nm-applet-0.9.10.0
	>=net-misc/networkmanager-0.9.10.0[modemmanager]
	>=net-misc/modemmanager-0.7.990

	virtual/opengl
	x11-apps/xmodmap
	x11-libs/cairo
	x11-libs/libX11
	x11-libs/libXxf86misc
	>=x11-libs/libXi-1.2

	bluetooth? ( >=net-wireless/gnome-bluetooth-3.14.0:= )
	colord? (
		net-libs/libsoup:2.4
		>=x11-misc/colord-0.1.34:0=
		>=x11-libs/colord-gtk-0.1.24 )
	cups? (
		>=net-print/cups-1.4[dbus]
		|| ( >=net-fs/samba-3.6.14-r1[smbclient] >=net-fs/samba-4.0.0[client] ) )
	gnome-online-accounts? (
		>=media-libs/grilo-0.2.11:0.2
		>=net-libs/gnome-online-accounts-3.9.90 )
	i18n? ( >=app-i18n/ibus-1.5.2 )
	kerberos? ( app-crypt/mit-krb5 )
	v4l? (
		media-libs/gstreamer:1.0
		media-libs/clutter-gtk:1.0
		>=media-video/cheese-3.5.91 )
	input_devices_wacom? (
		>=dev-libs/libwacom-0.7
		>=media-libs/clutter-1.20.0:1.0
		media-libs/clutter-gtk:1.0
		>=x11-libs/libXi-1.2 )
"
# <gnome-color-manager-3.1.2 has file collisions with g-c-c-3.1.x
# libgnomekbd needed only for gkbd-keyboard-display tool
RDEPEND="${COMMON_DEPEND}
	|| ( ( app-admin/openrc-settingsd sys-auth/consolekit ) >=sys-apps/systemd-31 )
	>=sys-apps/accountsservice-0.6.30
	x11-themes/adwaita-icon-theme
	colord? ( >=gnome-extra/gnome-color-manager-3 )
	cups? (
		>=app-admin/system-config-printer-gnome-1.3.5
		net-print/cups-pk-helper )
	input_devices_wacom? ( gnome-base/gnome-settings-daemon[input_devices_wacom] )
	i18n? ( >=gnome-base/libgnomekbd-3 )

	!<gnome-base/gdm-2.91.94
	!<gnome-extra/gnome-color-manager-3.1.2
	!gnome-extra/gnome-media[pulseaudio]
	!<gnome-extra/gnome-media-2.32.0-r300
	!<net-wireless/gnome-bluetooth-3.3.2
	deprecated? ( sys-power/upower[deprecated] )
"
# PDEPEND to avoid circular dependency
PDEPEND=">=gnome-base/gnome-session-2.91.6-r1"

DEPEND="${COMMON_DEPEND}
	x11-proto/xproto
	x11-proto/xf86miscproto
	x11-proto/kbproto

	dev-libs/libxml2:2
	dev-libs/libxslt
	>=dev-util/intltool-0.40.1
	>=sys-devel/gettext-0.17
	virtual/pkgconfig

	cups? ( sys-apps/sed )

	gnome-base/gnome-common
"
# Needed for autoreconf
#	gnome-base/gnome-common

src_prepare() {
	if use deprecated; then
		# From Funtoo:
		# 	https://bugs.funtoo.org/browse/FL-1329
		epatch "${FILESDIR}"/${PN}-3.14.1-restore-deprecated-code.patch
	fi

	# Gentoo handles completions in a different directory, bugs #465094 and #477390
	sed -i "s|^completiondir =.*|completiondir = $(get_bashcompdir)|" \
		shell/Makefile.am || die "sed completiondir failed"

	# Make some panels and dependencies optional; requires eautoreconf
	# https://bugzilla.gnome.org/686840, 697478, 700145
	if use deprecated; then
		# From Funtoo:
		# 	https://bugs.funtoo.org/browse/FL-1329
		epatch "${FILESDIR}"/${P}-optional-rebased.patch
	else
		epatch "${FILESDIR}"/${P}-optional.patch
	fi

	# From Funtoo:
	# 	https://bugs.funtoo.org/browse/FL-1389
	epatch "${FILESDIR}"/${P}-disable-automatic-datetime-and-timezone-options.patch

	# From Funtoo:
	# 	https://bugs.funtoo.org/browse/FL-1391
	epatch "${FILESDIR}"/${P}-disable-changing-hostname.patch

	# Fix some absolute paths to be appropriate for Gentoo
	epatch "${FILESDIR}"/${PN}-3.10.2-gentoo-paths.patch

	epatch_user

	eautoreconf

	# panels/datetime/Makefile.am gets touched by "gentoo-paths" patch.
	# We need to touch timedated{c,h} to prevent them from being
	# regenerated (bug #415901)
	# Upstream think they should be removed, preventing compilation errors too
	# (https://bugzilla.gnome.org/704822)
	[[ -f panels/datetime/timedated.h ]] && rm -f panels/datetime/timedated.h
	[[ -f panels/datetime/timedated.c ]] && rm -f panels/datetime/timedated.c

	gnome2_src_prepare
}

src_configure() {
	gnome2_src_configure \
		--disable-update-mimedb \
		--disable-static \
		--enable-documentation \
		$(use_enable bluetooth) \
		$(use_enable colord color) \
		$(use_enable cups) \
		$(use_enable deprecated) \
		$(use_enable gnome-online-accounts goa) \
		$(use_enable i18n ibus) \
		$(use_enable kerberos) \
		$(use_with v4l cheese) \
		$(use_enable input_devices_wacom wacom)
}
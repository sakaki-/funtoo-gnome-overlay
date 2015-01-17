# Distributed under the terms of the GNU General Public License v2

EAPI="5"
GCONF_DEBUG="no"
GNOME2_LA_PUNT="yes"

inherit gnome2 readme.gentoo

DESCRIPTION="The Gnome Terminal"
HOMEPAGE="https://wiki.gnome.org/Apps/Terminal/"

LICENSE="GPL-3+"
SLOT="0"
IUSE="debug +deprecated +gnome-shell +nautilus"
KEYWORDS="*"

# FIXME: automagic dependency on gtk+[X]
RDEPEND="
	>=dev-libs/glib-2.42.0:2
	>=x11-libs/gtk+-3.14.0:3[X]
	x11-libs/vte:2.91
	>=gnome-base/dconf-0.14
	>=gnome-base/gconf-2.31.3
	>=gnome-base/gsettings-desktop-schemas-3.14.0
	sys-apps/util-linux
	x11-libs/libSM
	x11-libs/libICE
	gnome-shell? ( >=gnome-base/gnome-shell-3.14.0 )
	nautilus? ( >=gnome-base/nautilus-3.14.0 )
"
# gtk+:2 needed for gtk-builder-convert, bug 356239
DEPEND="${RDEPEND}
	app-text/yelp-tools
	dev-util/appdata-tools
	|| ( dev-util/gtk-builder-convert <=x11-libs/gtk+-2.24.10:2 )
	>=dev-util/intltool-0.50
	sys-devel/gettext
	virtual/pkgconfig
"

DOC_CONTENTS="To get previous working directory inherited in new opened
	tab you will need to add the following line to your ~/.bashrc:\n
	. /etc/profile.d/vte.sh"

src_prepare() {
	if use deprecated; then
		# From Fedora:
		# 	http://pkgs.fedoraproject.org/cgit/gnome-terminal.git/tree/restore-transparency.patch?h=f20-gnome-3-12
		epatch "${FILESDIR}"/${PN}-3.14.1-restore-background-transparency-support.patch
	fi
	epatch "${FILESDIR}"/${PN}-3.14.1-no-F1-help.patch
	gnome2_src_prepare
}
src_configure() {
	gnome2_src_configure \
		--disable-static \
		--enable-migration \
		$(use_enable debug) \
		$(use_enable gnome-shell search-provider) \
		$(use_with nautilus nautilus-extension) \
		VALAC=$(type -P true)
}

src_install() {
	DOCS="AUTHORS ChangeLog HACKING NEWS"
	gnome2_src_install
	readme.gentoo_create_doc
}

pkg_postinst() {
	gnome2_pkg_postinst
	readme.gentoo_print_elog
}

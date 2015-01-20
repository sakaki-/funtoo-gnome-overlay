# Distributed under the terms of the GNU General Public License v2

EAPI="5"
GCONF_DEBUG="no"
GNOME2_LA_PUNT="yes"

inherit gnome2

DESCRIPTION="Standard Themes for GNOME Applications"
HOMEPAGE="https://git.gnome.org/browse/gnome-themes-standard/"

LICENSE="LGPL-2.1+"
SLOT="0"
IUSE="+gtk"
KEYWORDS="*"

COMMON_DEPEND="
        gnome-base/librsvg:2
        x11-libs/cairo
        >=x11-themes/gtk-engines-2.15.3:2
        gtk? (
                >=x11-libs/gtk+-2.24.25:2
                >=x11-libs/gtk+-3.14.0:3 )
"
DEPEND="${COMMON_DEPEND}
        >=dev-util/intltool-0.40
        sys-devel/gettext
        virtual/pkgconfig
"
# gnome-themes{,-extras} are OBSOLETE for GNOME 3
# http://comments.gmane.org/gmane.comp.gnome.desktop/44130
# Depend on gsettings-desktop-schemas-3.4 to make sure 3.2 users don't lose
# their default background image
RDEPEND="${COMMON_DEPEND}
        >=gnome-base/gsettings-desktop-schemas-3.14.0
        !<x11-themes/gnome-themes-2.32.1-r1
"

src_configure() {
        # The icon cache needs to be generated in pkg_postinst()
        gnome2_src_configure \
                --disable-static \
                $(use_enable gtk gtk2-engine) \
                $(use_enable gtk gtk3-engine) \
                GTK_UPDATE_ICON_CACHE=$(type -P true)
}


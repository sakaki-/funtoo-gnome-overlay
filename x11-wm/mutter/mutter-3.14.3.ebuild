# Distributed under the terms of the GNU General Public License v2

EAPI="5"
GCONF_DEBUG="yes"

inherit eutils gnome2

DESCRIPTION="GNOME 3 compositing window manager based on Clutter"
HOMEPAGE="http://git.gnome.org/browse/mutter/"

LICENSE="GPL-2+"
SLOT="0"
IUSE="+introspection test wayland"
KEYWORDS="*"

COMMON_DEPEND="
        >=x11-libs/pango-1.36.0[X,introspection?]
        >=x11-libs/cairo-1.10[X]
        x11-libs/gdk-pixbuf:2[introspection?]
        >=x11-libs/gtk+-3.14.0:3[X,introspection?]
        >=dev-libs/glib-2.42.0:2
        >=media-libs/clutter-1.20.0:1.0[egl,introspection?,wayland?]
        >=media-libs/cogl-1.18.0:1.0=[introspection?]
        >=media-libs/libcanberra-0.26[gtk3]
        >=x11-libs/startup-notification-0.7
        >=x11-libs/libXcomposite-0.2
        >=gnome-base/gsettings-desktop-schemas-3.14.0[introspection?]
        gnome-base/gnome-desktop:3=
        >sys-power/upower-0.99:=

        x11-libs/libICE
        x11-libs/libSM
        x11-libs/libX11
        >=x11-libs/libXcomposite-0.2
        x11-libs/libXcursor
        x11-libs/libXdamage
        x11-libs/libXext
        x11-libs/libXfixes
        >=x11-libs/libXi-1.7
        x11-libs/libXinerama
        x11-libs/libXrandr
        x11-libs/libXrender
        x11-libs/libxcb
        x11-libs/libxkbfile
        >=x11-libs/libxkbcommon-0.4.3[X]
        x11-misc/xkeyboard-config

        gnome-extra/zenity

        introspection? ( >=dev-libs/gobject-introspection-0.9.5 )
"
DEPEND="${COMMON_DEPEND}
        >=dev-util/gtk-doc-am-1.15
        >=dev-util/intltool-0.41
        sys-devel/gettext
        virtual/pkgconfig
        x11-proto/xextproto
        x11-proto/xineramaproto
        x11-proto/xproto
        test? ( app-text/docbook-xml-dtd:4.5 )
        wayland? ( dev-libs/wayland )
"
RDEPEND="${COMMON_DEPEND}
        !x11-misc/expocity
"

src_prepare() {
        # Compat with Ubuntu metacity themes (e.g. x11-themes/light-themes)
        epatch "${FILESDIR}/${PN}-3.2.1-ignore-shadow-and-padding.patch"

        gnome2_src_prepare
}

src_configure() {
        gnome2_src_configure \
                --disable-static \
                --enable-sm \
                --enable-startup-notification \
                --enable-verbose-mode \
                --with-libcanberra \
                $(use_enable introspection)
}


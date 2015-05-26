# Distributed under the terms of the GNU General Public License v2

EAPI="5"
GCONF_DEBUG="yes"
GNOME2_LA_PUNT="yes"

inherit gnome2

DESCRIPTION="The Eye of GNOME image viewer"
HOMEPAGE="https://wiki.gnome.org/Apps/EyeOfGnome"

LICENSE="GPL-2+"
SLOT="1"
IUSE="+exif +introspection +jpeg lcms +svg tiff xmp"
KEYWORDS="*"

REQUIRED_USE="exif? ( jpeg )"

RDEPEND="
	>=x11-libs/gtk+-3.14.0:3[introspection,X]
	>=dev-libs/glib-2.42.0:2
	>=dev-libs/libxml2-2:2
	>=dev-libs/libpeas-1.12.0:=[gtk]
	>=gnome-base/gnome-desktop-3.14.0:3=
	>=gnome-base/gsettings-desktop-schemas-3.14.0
	x11-themes/adwaita-icon-theme
	>=x11-misc/shared-mime-info-0.20

	x11-libs/gdk-pixbuf:2[jpeg?,tiff?]
	x11-libs/libX11

	exif? ( >=media-libs/libexif-0.6.14 )
	introspection? ( >=dev-libs/gobject-introspection-1.42.0 )
	jpeg? ( virtual/jpeg:0 )
	lcms? ( media-libs/lcms:2 )
	svg? ( >=gnome-base/librsvg-2.40.0:2 )
	xmp? ( media-libs/exempi:2 )
"
DEPEND="${RDEPEND}
	>=dev-util/gtk-doc-am-1.16
	>=dev-util/intltool-0.50.1
	sys-devel/gettext
	virtual/pkgconfig
"

src_configure() {
	DOCS="AUTHORS ChangeLog HACKING MAINTAINERS NEWS README THANKS TODO"
	gnome2_src_configure \
		$(use_enable introspection) \
		$(use_with jpeg libjpeg) \
		$(use_with exif libexif) \
		$(use_with lcms cms) \
		$(use_with xmp) \
		$(use_with svg librsvg) \
		ITSTOOL=$(type -P true)
}

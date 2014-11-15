# Distributed under the terms of the GNU General Public License v2

EAPI="5"
GCONF_DEBUG="no"
GNOME2_LA_PUNT="yes" # plugins are dlopened
PYTHON_COMPAT=( python3_{2,3,4} )
VALA_MIN_API_VERSION="0.26"

inherit eutils gnome2 multilib python-r1 vala virtualx

DESCRIPTION="A text editor for the GNOME desktop"
HOMEPAGE="https://wiki.gnome.org/Apps/Gedit"

LICENSE="GPL-2+ CC-BY-SA-3.0"
SLOT="0"

IUSE="+introspection +python spell vala"
REQUIRED_USE="python? ( ${PYTHON_REQUIRED_USE} ) vala? ( introspection )"

KEYWORDS="*"

# X libs are not needed for OSX (aqua)
COMMON_DEPEND="
	>=dev-libs/libxml2-2.5.0:2
	>=dev-libs/glib-2.42.0:2
	>=x11-libs/gtk+-3.14.0:3[introspection?]
	>=x11-libs/gtksourceview-3.14.0:3.0[introspection?]
	>=dev-libs/libpeas-1.12.0[gtk]

	gnome-base/gsettings-desktop-schemas
	gnome-base/gvfs

	x11-libs/libX11

	net-libs/libsoup:2.4

	introspection? ( >=dev-libs/gobject-introspection-1.42.0 )
	python? (
		${PYTHON_DEPS}
		>=dev-libs/gobject-introspection-1.42.0
		>=x11-libs/gtk+-3.14.0:3[introspection]
		>=x11-libs/gtksourceview-3.14.0:3.0[introspection]
		dev-python/pycairo[${PYTHON_USEDEP}]
		>=dev-python/pygobject-3.14.0:3[cairo,${PYTHON_USEDEP}] )
	spell? (
		>=app-text/enchant-1.2:=
		>=app-text/iso-codes-0.35 )
"
RDEPEND="${COMMON_DEPEND}
	x11-themes/adwaita-icon-theme
	python? ( dev-libs/libpeas[${PYTHON_USEDEP}] )
"
DEPEND="${COMMON_DEPEND}
	app-text/docbook-xml-dtd:4.1.2
	>=app-text/scrollkeeper-0.3.11
	dev-libs/libxml2:2
	>=dev-util/gtk-doc-am-1
	>=dev-util/intltool-0.50.1
	>=sys-devel/gettext-0.18
	virtual/pkgconfig
	vala? ( $(vala_depend) )
"
# yelp-tools, gnome-common needed to eautoreconf

src_prepare() {
	# FIXME: Not able to set some metadata
	#sed -e '/g_test_add_func/d' \
	#	-i tests/document-loader.c || die

	use vala && vala_src_prepare
	gnome2_src_prepare

	python_copy_sources
}

src_configure() {
	DOCS="AUTHORS BUGS ChangeLog MAINTAINERS NEWS README"

	local myconf
	myconf="
		--disable-deprecations
		--enable-updater
		--enable-gvfs-metadata
		$(use_enable introspection)
		$(use_enable spell)
		$(use_enable vala)
		$(use_enable python)
		ITSTOOL=$(type -P true)
	"

	if use python ; then
		python_parallel_foreach_impl gnome2_src_configure ${myconf}
	else
		gnome2_src_configure ${myconf}
	fi
}

src_test() {
	# FIXME: this should be handled at eclass level
	"${EROOT}${GLIB_COMPILE_SCHEMAS}" --allow-any-name "${S}/data" || die

	unset DBUS_SESSION_BUS_ADDRESS
	GSETTINGS_SCHEMA_DIR="${S}/data" Xemake check
}

src_install() {
	if use python ; then
		python_foreach_impl gnome2_src_install
	else
		gnome2_src_install
	fi
}

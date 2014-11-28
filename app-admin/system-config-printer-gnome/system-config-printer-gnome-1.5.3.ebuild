# Distributed under the terms of the GNU General Public License v2

EAPI="5"
GCONF_DEBUG="no"
PYTHON_COMPAT=( python{3_3,3_4} )
PYTHON_REQ_USE="xml"

inherit autotools gnome2 eutils python-single-r1 versionator

MY_P="${PN%-gnome}-${PV}"
MY_V="$(get_version_component_range 1-2)"

DESCRIPTION="GNOME frontend for a Red Hat's printer administration tool"
HOMEPAGE="http://cyberelk.net/tim/software/system-config-printer/"
SRC_URI="http://cyberelk.net/tim/data/system-config-printer/${MY_V}/${MY_P}.tar.xz"

LICENSE="GPL-2"
KEYWORDS="*"
SLOT="0"
IUSE="gnome-keyring policykit +python_single_target_python3_3"
REQUIRED_USE="${PYTHON_REQUIRED_USE}"

# Needs cups running, bug 284005
RESTRICT="test"

RDEPEND="
	${PYTHON_DEPS}
	!app-admin/system-config-printer-common
	dev-libs/libxml2[python,${PYTHON_USEDEP}]
	dev-python/dbus-python[${PYTHON_USEDEP}]
	dev-python/pycairo[${PYTHON_USEDEP}]
	>=dev-python/pycups-1.9.60[${PYTHON_USEDEP}]
	dev-python/pycurl[${PYTHON_USEDEP}]
	dev-python/pygobject:3[${PYTHON_USEDEP}]
	gnome-keyring? ( gnome-base/libgnome-keyring[introspection] )
	net-print/cups[dbus]
	virtual/libusb:1
	>=virtual/udev-172
	x11-libs/gtk+:3[introspection]
	x11-libs/libnotify[introspection]
	x11-libs/pango[introspection]
"
DEPEND="${RDEPEND}
	app-text/docbook-xml-dtd:4.1.2
	>=app-text/xmlto-0.0.22
	dev-util/desktop-file-utils
	dev-util/intltool
	policykit? ( >=sys-auth/polkit-0.104-r1 )
	sys-devel/gettext
	virtual/pkgconfig
"

APP_LINGUAS="ar as bg bn_IN bn br bs ca cs cy da de el en_GB es et fa fi fr gu
he hi hr hu hy id is it ja ka kn ko lo lv mai mk ml mr ms nb nl nn or pa pl
pt_BR pt ro ru si sk sl sr@latin sr sv ta te th tr uk vi zh_CN zh_TW"
for X in ${APP_LINGUAS}; do
	IUSE="${IUSE} linguas_${X}"
done

S="${WORKDIR}/${MY_P}"

# Bug 471472
MAKEOPTS+=" -j1"

pkg_setup() {
	python-single-r1_pkg_setup
}

src_configure() {
	local myconf

	# Disable installation of translations when LINGUAS not chosen
	if [[ -z "${LINGUAS}" ]]; then
		myconf="${myconf} --disable-nls"
	else
		myconf="${myconf} --enable-nls"
	fi

	gnome2_src_configure \
		--with-desktop-vendor=Funtoo \
		--with-udev-rules \
		${myconf}
}

src_install() {
	gnome2_src_install
	python_fix_shebang "${ED}"
}

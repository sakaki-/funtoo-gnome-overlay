# Distributed under the terms of the GNU General Public License v2

EAPI="5"
GCONF_DEBUG="no"
VALA_MIN_API_VERSION="0.14"
VALA_USE_DEPEND="vapigen"
# FIXME: Claims to works with python3 but appears to be wishful thinking
PYTHON_COMPAT=( python{2_6,2_7} )
PYTHON_REQ_USE="xml"

inherit gnome2 multilib-minimal python-r1 vala

DESCRIPTION="An object-oriented framework for creating UPnP devs and control points"
HOMEPAGE="http://gupnp.org/"

LICENSE="LGPL-2"
SLOT="0/4"
KEYWORDS="*"
IUSE="connman +introspection kernel_linux networkmanager"

REQUIRED_USE="${PYTHON_REQUIRED_USE}"

RDEPEND="
	${PYTHON_DEPS}
	>=net-libs/gssdp-0.13.0:0=[introspection?,${MULTILIB_USEDEP}]
	>=net-libs/libsoup-2.28.2:2.4[introspection?,${MULTILIB_USEDEP}]
	>=dev-libs/glib-2.24:2[${MULTILIB_USEDEP}]
	dev-libs/libxml2[${MULTILIB_USEDEP}]
	|| (
		>=sys-apps/util-linux-2.16[${MULTILIB_USEDEP}]
		<sys-libs/e2fsprogs-libs-1.41.8[${MULTILIB_USEDEP}] )
	introspection? (
			>=dev-libs/gobject-introspection-0.6.4
			$(vala_depend) )
	connman? (
		>=dev-libs/glib-2.28:2[${MULTILIB_USEDEP}]
		>=net-misc/connman-0.80[${MULTILIB_USEDEP}] )
	networkmanager? ( >=dev-libs/glib-2.26:2[${MULTILIB_USEDEP}] )
	!net-libs/gupnp-vala
"
DEPEND="${RDEPEND}
	>=dev-util/gtk-doc-am-1
	sys-devel/gettext
	>=virtual/pkgconfig-0-r1[${MULTILIB_USEDEP}]
"

src_prepare() {
	use introspection && vala_src_prepare
	gnome2_src_prepare
}

multilib_src_configure() {
	local backend=unix
	use kernel_linux && backend=linux
	use connman && backend=connman
	use networkmanager && backend=network-manager
	ECONF_SOURCE="${S}" \
	gnome2_src_configure \
		$(multilib_use_enable introspection) \
		--disable-static \
		--with-context-manager=${backend}
   	if multilib_is_native_abi; then
		ln -s "${S}"/doc/html doc/html || die
	fi
}

multilib_src_install() {
	gnome2_src_install
}

multilib_src_install_all() {
	einstalldocs
	python_parallel_foreach_impl python_doscript tools/gupnp-binding-tool
}

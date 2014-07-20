# Distributed under the terms of the GNU General Public License v2

EAPI=5
inherit eutils git-2 systemd

DESCRIPTION="D-Bus abstraction for enumerating power devices and querying history and statistics"
HOMEPAGE="http://upower.freedesktop.org/"
EGIT_REPO_URI="git://anongit.freedesktop.org/upower"
EGIT_COMMIT="dbf7eb7e557674a9b888a088f1cae4f36b77e14d"

LICENSE="GPL-2"
SLOT="0/2" # based on SONAME of libupower-glib.so
KEYWORDS="~*"
IUSE="deprecated +introspection ios kernel_FreeBSD kernel_linux"

RDEPEND=">=dev-libs/dbus-glib-0.100
	>=dev-libs/glib-2.30
	sys-apps/dbus:=
	>=sys-auth/polkit-0.110
	introspection? ( dev-libs/gobject-introspection )
	kernel_linux? (
		virtual/libusb:1
		virtual/libgudev:=
		virtual/udev
		ios? (
			>=app-pda/libimobiledevice-1:=
			>=app-pda/libplist-1:=
			)
		)
	dev-util/gtk-doc
	deprecated? ( >=sys-power/pm-utils-1.4.1-r2 )"
DEPEND="${RDEPEND}
	dev-libs/libxslt
	app-text/docbook-xsl-stylesheets
	dev-util/intltool
	virtual/pkgconfig"

QA_MULTILIB_PATHS="usr/lib/${PN}/.*"

DOCS="AUTHORS HACKING NEWS README"

src_prepare() {
	if use deprecated; then
		# From Funtoo:
		# 	https://bugs.funtoo.org/browse/FL-1329
		epatch "${FILESDIR}"/${P}-restore-deprecated-code.patch

		# From Debian:
		#	https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=718458
		#	https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=718491
		epatch "${FILESDIR}"/${PN}-0.99.0-always-use-pm-utils-backend.patch
	fi

	# From Upstream:
	# 	http://cgit.freedesktop.org/upower/commit/?id=212b4397ccba17caf86206e2b265c0c2e4ad158c
	# 	http://cgit.freedesktop.org/upower/commit/?id=dbb9bead6d3b9e70a5d58019b1615d2a6fba5312
	# 	http://cgit.freedesktop.org/upower/commit/?id=b1aeed994884602b3601a7f4b98419c65be9009c
	# 	http://cgit.freedesktop.org/upower/commit/?id=3b6948bc4bbdd68b5ed3a974e57a156a79c1a7b8
	epatch \
		"${FILESDIR}"/${PN}-0.99.0-fix-api-doc.patch \
		"${FILESDIR}"/${PN}-0.99.0-fix-small-memleak-on-startup-with-logitech-devices.patch \
		"${FILESDIR}"/${PN}-0.99.0-fix-possible-uphistoryitem-leak-on-failure.patch \
		"${FILESDIR}"/${PN}-0.99.0-add-missing-include.patch

	if [[ ! -e configure ]] ; then
		./autogen.sh || die
	fi
}

src_configure() {
	local backend

	if use kernel_linux; then
		backend=linux
	elif use kernel_FreeBSD; then
		backend=freebsd
	else
		backend=dummy
	fi

	econf \
		--libexecdir="${EPREFIX}"/usr/lib/${PN} \
		--localstatedir="${EPREFIX}"/var \
		--disable-static \
		--enable-man-pages \
		--disable-tests \
		--enable-gtk-doc \
		--enable-gtk-doc-html \
		--with-html-dir="${EPREFIX}"/usr/share/doc/${PF}/html \
		--with-backend=${backend} \
		$(use_enable deprecated) \
		$(use_enable introspection) \
		$(use_with ios idevice) \
		"$(systemd_with_utildir)" \
		"$(systemd_with_unitdir)"
}

src_install() {
	default

	# http://bugs.gentoo.org/487400
	insinto /usr/share/doc/${PF}/html/UPower
	doins doc/html/*
	dosym /usr/share/doc/${PF}/html/UPower /usr/share/gtk-doc/html/UPower

	keepdir /var/lib/upower #383091
	prune_libtool_files
}

# ebuild to install NX Web Companion
inherit webapp eutils versionator

DESCRIPTION="NX Web Companion is the web client package for nomachine.org's nxserver"
HOMEPAGE="http://www.nomachine.com/"

# package version without patch level (e.g. 3.3.0)
MY_PV_M="$(get_version_component_range 1-3)"

# package version with patch level (e.g. 3.3.0-2)
MY_PV_P="$(replace_version_separator 3 '-')"

SRC_URI="http://64.34.161.181/download/${MY_PV_M}/Linux/nxplugin-${MY_PV_P}.i386.tar.gz"
LICENSE="nomachine"
KEYWORDS="~amd64 ~x86"
IUSE=""
RESTRICT="mirror"

DEPEND=">=net-misc/nxserver-freeedition-${MY_PV_M}"

src_unpack() {
	unpack ${A}
	
	epatch ${FILESDIR}/nxapplet-disable-java-check.patch
}


src_install() {
	webapp_src_preinst

	einfo "Patching nxapplet.html with server hostname: ${VHOST_HOSTNAME}"
	sed -i -e "s|http://webserver|http://${VHOST_HOSTNAME}/${PN}|" usr/NX/share/plugin/nxapplet.html
	[ "$VHOST_HOSTNAME" = localhost ] && ewarn "Server hostname is localhost, the plugin will not be usable from remote hosts"

	cp -R usr/NX/share/* ${D}/${MY_HTDOCSDIR}

	#TODO: webapp_postinst_txt en ${FILESDIR}/postinstall-en.txt
	# Note to the user that she can access the client at http://localhost/nxweb/plugin/nxapplet.html

	webapp_src_install
}

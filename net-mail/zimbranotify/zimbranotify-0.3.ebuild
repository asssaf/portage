# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI="2"

DESCRIPTION="ZimbraNotify, Linux Toaster wannabe, works on the system tray checking and notifying about new emails."
SRC_URI="http://gallery.zimbra.com/download/98/99 -> ${P}.zip"
HOMEPAGE="http://wiki.zimbra.com/wiki/ZimbraNotify"
LICENSE="GPL"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND="dev-lang/perl[ithreads]
	dev-perl/gtk2-trayicon
	dev-perl/XML-Simple
	dev-perl/Crypt-SSLeay
	crypt? ( dev-perl/FreezeThaw dev-perl/Crypt-Simple dev-perl/Crypt-Blowfish )
	clickable-urls? ( dev-perl/Gtk2-Sexy )"

IUSE="+crypt clickable-urls"


src_install() {
	exeinto /usr/bin
	newexe ${WORKDIR}/${PN} ${PN}
}

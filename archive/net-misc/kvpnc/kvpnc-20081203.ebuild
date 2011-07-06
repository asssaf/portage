# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI="2"

#NEED_KDE=":4.1"
inherit kde4-base

MY_P=${PN}_${PV}-kde4
S=${WORKDIR}/${MY_P}
DESCRIPTION="kvpnc - a KDE-VPN connection utility."
SRC_URI="http://download.gna.org/${PN}/testing/${MY_P}.tar.gz"
#http://download.gna.org/kvpnc/testing/kvpnc_20081203-kde4.tar.gz
HOMEPAGE="http://home.gna.org/kvpnc/"

LICENSE="GPL-2"
KEYWORDS="~amd64 ~x86"
SLOT="4.1"
IUSE="debug cisco smartcard"

DEPEND="dev-libs/libgcrypt"
RDEPEND="cisco? ( >=net-misc/vpnc-0.4 )
	smartcard? ( >=dev-libs/openct-0.6.11-r1 )"

src_configure() {
	if use debug; then
		mycmakeargs="${mycmakeargs} -DCMAKE_BUILD_TYPE=debugfull"
	fi
	mycmakeargs="${mycmakeargs}
		-DCMAKE_INSTALL_PREFIX=${PREFIX}
	"
	kde4-base_src_configure
}

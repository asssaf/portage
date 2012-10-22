# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emulation/qemu-kvm/qemu-kvm-9999.ebuild,v 1.16 2011/03/28 03:31:46 flameeyes Exp $

EAPI="2"

inherit versionator

MY_PV=$(get_version_component_range 1-3)
MY_PV2=$(replace_all_version_separators '_' $MY_PV)
MY_BN=$(get_version_component_range 4)
MY_BD=$(get_version_component_range 5)
MY_PN="zdesktop"

MY_P="${MY_PN}_${MY_PV2}_ga_b${MY_BN}"
MY_P2="${MY_P}_${MY_BD}_linux_i686"
S="${WORKDIR}/${MY_P}_linux_i686"

#http://files2.zimbra.com/downloads/${MY_PN}/7.2.1/b11637/${MY_P}.tgz
DESCRIPTION=""
SRC_URI="http://files2.zimbra.com/downloads/zdesktop/${MY_PV}/b${MY_BN}/${MY_P2}.tgz"
HOMEPAGE=""
#LICENSE="zimbra"
SLOT="0"
KEYWORDS="~amd64"

#TODO depends 32bit libraries?

IUSE=""

#TODO show license

src_install() {
	#TODO: unpack directly to ${D} to prevent double copy?
	#TODO: don't install bundled JRE
	DDEST="/opt/zimbra"
	dodir ${DDEST}
	cp -R "${S}/app" "${D}/${DDEST}/${MY_PN}" || die "Install failed!"
}

#TODO show message for installing user data
# mkdir ~/zdesktop/{log,sqlite,store,zimlets-deployed}


# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2"

inherit versionator

MY_PN="VMware-ovftool-$(replace_version_separator 3 - $PV)"
MY_P="${MY_PN}-lin.x86_64.sh"

DESCRIPTION=""
HOMEPAGE=""
#DOWNLOAD_URL="http://www.vmware.com/downloads/download.do?downloadGroup=OVF-TOOL-2-0-1"
DOWNLOAD_URL="http://communities.vmware.com/community/vmtn/vsphere/automationtools/ovf"
SRC_URI="amd64? ( ${MY_P} )"

LICENSE="vmware"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""
RESTRICT="strip fetch binchecks"
PROPERTIES="interactive"

S="${WORKDIR}/ovftool"

pkg_nofetch() {
	einfo "Please download the ${MY_PN}-lin.x86_64.sh from"
	einfo "${DOWNLOAD_URL}"
	einfo "and place it in ${DISTDIR}"
}

src_unpack() {
	# find from where we want to skip to get archive
	SKIP=`awk '/^__ARCHIVE_FOLLOWS__/ {print NR +1; exit 0;}' ${DISTDIR}/${A}` || die "Failed to unpack ${A}"

	tail -n +$SKIP ${DISTDIR}/${A} | tar xz -C ${WORKDIR} || die "Failed to unpack ${A}"

	echo 'Please read the EULA and accept to continue install'


	if  [ -e /usr/bin/less ]; then
		SHOWCMD='/usr/bin/less'
	else 
		if [ -e /bin/more ]; then
			SHOWCMD='/bin/more'
		else
			SHOWCMD='/bin/cat'
		fi
	fi

	$SHOWCMD "${WORKDIR}/ovftool/vmware.eula"

	echo -n 'Accept VMware OVF Tool EULA (yes or no)? '
	read aws
	while [ "$aws" != "no" -a "$aws" != "yes" ]; do
		echo -n "Accept VMware OVF Tool EULA (yes or no, please write yes or no)? "
		read aws
	done

	if [ "$aws" = "no" ]; then
		die "EULA was not accepted"
		
	fi
}

src_install() {
	dodir /opt/vmware/ovftool || die
	cp -R ${S}/* ${D}/opt/vmware/ovftool || die "Install failed"
	
	dosym /opt/vmware/ovftool/ovftool /usr/bin/ovftool || die "Failed to create ovftool symlink"
}

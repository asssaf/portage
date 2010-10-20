# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header$

inherit java-pkg-2

DESCRIPTION=""
HOMEPAGE=""
MY_PN="${PN%-bin}"
MY_PV="${PV%_p*}"
MY_PV2="${PV//_p/-}"
# the only difference between the 32 and 64 bit distributions is the swt library, which we dump anyway
MY_P="${MY_PN}-linux-x86-${MY_PV2}"
SRC_URI="http://downloads.sourceforge.net/project/${MY_PN}/${MY_PN}/${MY_PV}/${MY_P}.tgz"
S="${WORKDIR}/${MY_P}"

RESTRICT="nomirror"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=">=virtual/jdk-1.6"
RDEPEND=">=virtual/jre-1.6
	dev-java/swt:3.6"

EANT_BUILD_TARGET="dist"
EANT_ANT_TASKS="ant-nodeps"


src_install() {
	local davmail_home="${ROOT}/usr/share/${PN}"

	insinto "${davmail_home}"

	java-pkg_newjar "${MY_PN}.jar"

	# use local swt because the bundled one extracts to /tmp which might have noexec set
	java-pkg_jar-from swt-3.6

	cd lib
	for jar in *.jar; do
		if [ "$jar" != "swt-3.6-gtk-linux-x86.jar" ]
		then
	                java-pkg_newjar ${jar} ${jar}
		fi
        done

	java-pkg_dolauncher "davmail" --main davmail.DavGateway
}

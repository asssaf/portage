# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=3

inherit toolchain-funcs

DESCRIPTION="Compressed RAM based block devices"
HOMEPAGE="http://compcache.googlecode.com/"
SLOT=0
SRC_URI=""

LICENSE="GPL-2 LGPL-2.1"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="!sys-block/zramconfig"

src_install() {
	newinitd "${FILESDIR}/init.d-${PN}" ${PN} || die
	newconfd "${FILESDIR}/conf.d-${PN}" ${PN} || die
}

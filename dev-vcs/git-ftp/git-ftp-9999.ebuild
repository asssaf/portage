# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emulation/qemu-kvm/qemu-kvm-9999.ebuild,v 1.16 2011/03/28 03:31:46 flameeyes Exp $

EAPI="2"

inherit git

DESCRIPTION="Git powered FTP client written as shell script."
EGIT_REPO_URI="https://github.com/resmo/git-ftp.git"
HOMEPAGE="https://github.com/resmo/git-ftp"
LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64"

IUSE=""

RDEPEND="dev-vcs/git"

src_install() {
        emake prefix="${D}/usr" install || die "make install failed"
}


# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=2
inherit eutils toolchain-funcs

MY_REV="998e0e75666f31c278affbab687dca84b94ea20d"

DESCRIPTION="A full-screen Expose-style standalone task switcher for X11"
HOMEPAGE="https://github.com/richardgv/skippy-xd"
SRC_URI="https://github.com/richardgv/${PN}/archive/${MY_REV}.zip -> ${P}.zip"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

RDEPEND="media-libs/imlib2[X]
	x11-libs/libXext
	x11-libs/libX11
	x11-libs/libXinerama
	x11-libs/libXmu
	x11-libs/libXft"
DEPEND="${RDEPEND}
	x11-proto/xproto
	x11-proto/xineramaproto
	virtual/pkgconfig"

S="${WORKDIR}/${PN}-${MY_REV}"

src_compile() {
	tc-export CC
	emake || die
}

src_install() {
	emake DESTDIR="${D}" install || die
	dodoc CHANGELOG skippy-xd.sample.rc
}
pkg_postinst() {
	echo
	elog "You should copy skippy-xd.sample.rc"
	elog "from /usr/share/doc/${PF} to ~/.config/skippy-xd/skippy-xd.rc"
	elog "and edit the keysym used to invoke skippy."
	elog "Use x11-apps/xev to find out the keysym."
	echo
}

# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

MY_P="${P//_/}"

EAPI="2"
PYTHON_DEPEND="2:2.6:2.7"

inherit eutils python games

DESCRIPTION="A game of musical skill and fast fingers"
HOMEPAGE="http://code.google.com/p/fofix"
SRC_URI="http://fofix.googlecode.com/files/${MY_P}.tar.bz2"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="dev-libs/glib:2
	dev-python/cython
	media-libs/libogg
	media-libs/libtheora
	media-video/ffmpeg
	virtual/opengl"

RDEPEND="${DEPEND}
	dev-python/pygame
	dev-python/pyopengl
	dev-python/numpy
	dev-python/imaging
	dev-python/pyogg
	dev-python/pyvorbis
	dev-python/pysqlite:2
	dev-python/pyxml"

S="${WORKDIR}/${MY_P}"

pkg_setup() {
	SRC_DIR="$(games_get_libdir)/${PN}"
	DATA_DIR="${GAMES_DATADIR}/${PN}"
}

src_prepare() {
	# Use our own data directory.
	sed -i "s:os\.path\.join(\"\.\.\", \"data\"):'${DATA_DIR//'/\\'}':g" src/Version.py || die
}

src_compile() {
	cd src || die
	python setup.py build_ext --inplace || die
}

src_install() {
	# We have to ignore .pyc files.
	insinto "${SRC_DIR}"
	doins src/*.py src/*.pot src/*.so || die
	insinto "${SRC_DIR}/midi"
	doins src/midi/*.py || die

	# We don't need setup.py any more.
	rm "${D}${SRC_DIR}/setup.py" || die

	# Make FoFiX.py executable so we can start via symlink.
	chmod a+x "${D}${SRC_DIR}/FoFiX.py" || die

	# Create that symlink.
	dodir "${GAMES_BINDIR}" || die
	ln -s "${SRC_DIR}/FoFiX.py" "${D}${GAMES_BINDIR}/${PN}" || die

	insinto "${DATA_DIR}"
	doins -r data/* || die

	newicon data/fofix_icon.png "${PN}.png" || die
	make_desktop_entry "${PN}" "Frets on Fire X" || die

	dodoc AUTHORS CREDITS README doc/{Features-Manual.txt,Notices.txt,RunningFromSource.mkd} \
		doc/{"FOF Help.chm","FoFiX Options.pdf"} || die

	prepgamesdirs
}

pkg_postinst() {
	python_mod_optimize "${SRC_DIR}"
	games_pkg_postinst
}

pkg_postrm() {
	python_mod_cleanup "${SRC_DIR}"
}

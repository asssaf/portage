EAPI=6

DESCRIPTION="The next generation code editor"
HOMEPAGE="http://lighttable.com/"
MY_PN="${PN%%-bin}"
MY_P="${MY_PN}-${PV}"
MY_PA="${MY_P}-linux"
SRC_URI="https://github.com/LightTable/LightTable/releases/download/${PV}/${MY_PA}.tar.gz"

RESTRICT="mirror strip"
LICENSE=""
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

DEPEND="
	x11-libs/libnotify
	dev-libs/libgcrypt
	virtual/libudev
"

RDEPEND="${DEPEND}"

S="${WORKDIR}/${MY_PA}"

src_install() {
	insinto /opt/${MY_PN}
	doins -r * || die

	exeinto /opt/${MY_PN}
	doexe LightTable

	dosym /opt/${MY_PN}/LightTable /usr/bin/LightTable
}

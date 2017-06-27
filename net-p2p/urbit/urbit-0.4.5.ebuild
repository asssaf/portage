EAPI=6

DESCRIPTION="a secure peer-to-peer network of personal servers, built on a clean-slate system software stack"
HOMEPAGE="https://urbit.org/"
SRC_URI="https://media.urbit.org/dist/src/$P.tar.gz"
RESTRICT="mirror"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="dev-util/ragel
	dev-util/cmake
	dev-util/re2c"

RDEPEND="dev-libs/libsigsegv
	dev-libs/gmp
	dev-libs/openssl
	sys-libs/ncurses
	net-misc/curl"

src_install() {
	dobin bin/urbit
}

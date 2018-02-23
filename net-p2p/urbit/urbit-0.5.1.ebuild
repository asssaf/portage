EAPI=6

inherit eutils

DESCRIPTION="a secure peer-to-peer network of personal servers, built on a clean-slate system software stack"
HOMEPAGE="https://urbit.org/"
SRC_URI="https://codeload.github.com/urbit/urbit/tar.gz/v${PV} -> ${P}.tar.gz"
RESTRICT="mirror"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="extras +system-libuv"

RDEPEND="dev-util/ragel
	dev-util/cmake
	dev-util/re2c
	dev-libs/libsigsegv
	dev-libs/gmp
	dev-libs/openssl
	sys-libs/ncurses
	net-misc/curl
        system-libuv? ( dev-libs/libuv )"
DEPEND="${RDEPEND}"

src_prepare() {
	epatch ${FILESDIR}/system-include.patch
	use system-libuv && epatch ${FILESDIR}/system-libuv.patch && rm -r ${WORKDIR}/${P}/outside/libuv-v1.7.5
	eapply_user
}

src_compile() {
	# force non parallel make, otherwise there are some nondeterministic failures
	emake || die "emake failed"
}

src_install() {
	dobin bin/urbit
	dodoc CONTRIBUTING.md LICENSE.txt README.md
	dodoc -r Spec

	if use extras ; then
		insinto /usr/share/$PN
		doins -r extras
	fi
}

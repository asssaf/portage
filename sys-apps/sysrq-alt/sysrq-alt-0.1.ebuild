EAPI=6

DESCRIPTION="Assign SysRq button to an alternative scancode using EVIOCSKEYCODE, useful for keyboards without SysRq (e.g. macbooks)"
HOMEPAGE="https://github.com/asssaf/sysrq-alt"
SRC_URI="https://github.com/asssaf/${PN}/archive/v${PV}.tar.gz -> $P.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"

RESTRICT="nomirror"

src_install() {
	dobin sysrq-alt
}

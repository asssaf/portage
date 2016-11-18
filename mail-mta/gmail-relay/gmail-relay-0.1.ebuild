EAPI=6

inherit systemd

DESCRIPTION="Simple MTA that uses gmail API using a client OAuth token to send mail"
HOMEPAGE="https://github.com/asssaf/gmail-relay"
SRC_URI="https://github.com/asssaf/${PN}/archive/v${PV}.tar.gz -> $P.tar.gz"

RESTRICT="mirror"
LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

DEPEND="
	dev-python/google-api-python-client
"

RDEPEND="${DEPEND}"

#S="${WORKDIR}/${MY_PA}"

src_install() {
	dobin gmail-relay.py
	dobin gmail-relay-process-queue

	keepdir /etc/gmail-relay
	systemd_dounit contrib/systemd/gmail-relay.{service,timer,path}
}

pkg_postinst() {
	einfo "In order to use gmail-relay the Gmail API needs to be enabled and authorized."
	einfo "See https://developers.google.com/gmail/api/quickstart/python for instructions."
	einfo ""
	einfo "Then follow the instructions in https://github.com/asssaf/gmail-relay/blob/master/README.md"
}

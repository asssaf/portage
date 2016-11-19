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
	einfo "For use as normal user:"
	einfo "======================="
	einfo "Place the downloaded client_secret.json in ~/.gmail-relay/ and you're good to go."
	einfo "Authorization will be done through the browser on the first use (or whenever needed)."
	einfo ""
	einfo "For use as a system user:"
	einfo "========================="
	einfo "Place the download client_secret.json in /etc/gmail-relay/ and then run"
	einfo ""
	einfo "\t$ emerge --config =${P}"
	einfo ""
	einfo "and follow the instructions."
}

pkg_config() {
	if [ -r /etc/gmail-relay/credentials.json -o -r /etc/gmail-relay/client_secret.json ]
	then
		einfo "Attempting to authorize. If this is the first run or previous credentials are invalid"
		einfo "you'll be presented with a URL for authorization."

		if /usr/bin/gmail-relay.py --auth --noauth_local_webserver --config=/etc/gmail-relay
		then
			einfo "Done"
		else
			eerror "Failed to authorize"
		fi
	else
		eerror "Can't read /etc/gmail-relay/client_secret.json"
	fi
}

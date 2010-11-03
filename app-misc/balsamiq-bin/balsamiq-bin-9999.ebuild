EAPI="2"

inherit eutils

MY_PN=${PN%%-bin}

DESCRIPTION="Balsamiq Mockups for desktop"
HOMEPAGE="http://balsamiq.com"
SRC_URI="http://builds.balsamiq.com/b/mockups-desktop/MockupsForDesktop.air"
RESTRICT="mirror"

LICENSE=""
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE=""

RDEPEND="dev-libs/adobe-air-sdk-bin"

#S="${WORKDIR}"

src_unpack() {
	einfo "Unpacking the AIR archive"
	unzip ${DISTDIR}/${A} icons/*
}

src_install() {
	insinto "/usr/share/${PN}"
	doins "${DISTDIR}/${A}"

	insinto "/usr/share/${PN}/icons"
	doins "${WORKDIR}/icons/icon48.png"

	einfo "Creating launcher in ${WORKDIR}/${MY_PN}"
	make_launcher "${WORKDIR}/${MY_PN}" "${ROOT}/usr/share/${PN}/${A}"

	exeinto /usr/bin
	doexe "${WORKDIR}/${MY_PN}"

	make_desktop_entry "${MY_PN}" Balsamiq "${ROOT}/usr/share/${PN}/icons/icon48.png" "Graphics"
}


make_launcher() {
	local launcher_path="$1"
	local archive_path="$2"
	cat <<- EOF > "${launcher_path}"
	#!/bin/bash
	exec airstart "${archive_path}"
	EOF
}


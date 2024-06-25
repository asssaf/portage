# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

DESCRIPTION="Firmware for the Apple Facetime HD Camera"
HOMEPAGE=""
SRC_URI=""

LICENSE=""
SLOT="0"
KEYWORDS="~amd64"
IUSE=""
RESTRICT="network-sandbox"

DEPEND="
	app-arch/cpio
	app-arch/gzip
	app-arch/xz-utils
	net-misc/curl
	sys-apps/coreutils
"
RDEPEND="${DEPEND}"

S=${WORKDIR}

PKG_URL="https://updates.cdn-apple.com/2019/cert/041-88431-20191011-e7ee7d98-2878-4cd9-bc0a-d98b3a1e24b1/OSXUpd10.11.5.dmg"
PKG_RANGE="204909802-207733123"

CAM_IF_FILE="AppleCameraInterface"
CAM_IF_PKG_PATH="./System/Library/Extensions/AppleCameraInterface.kext/Contents/MacOS/AppleCameraInterface"
CAM_IF_SHA256="f56e68a880b65767335071531a1c75f3cfd4958adc6d871adf8dbf3b788e8ee1"

FIRMWARE_OFFSET="81920"
FIRMWARE_SIZE="603715"
FIRMWARE_FILE="firmware.bin"
FIRMWARE_DIR="facetimehd"
FIRMWARE_SHA256="e3e6034a67dfdaa27672dd547698bbc5b33f47f1fc7f5572a2fb68ea09d32d3d"

src_unpack() {
	curl -s -L -r ${PKG_RANGE} ${PKG_URL} | xzcat -q |\
			cpio --format odc -i --to-stdout ${CAM_IF_PKG_PATH} > ${CAM_IF_FILE}
	echo "${CAM_IF_SHA256} ${CAM_IF_FILE}" | sha256sum -c || die "camera interface checksum mismatch"
	dd bs=1 skip=${FIRMWARE_OFFSET} count=${FIRMWARE_SIZE} if=${CAM_IF_FILE} |\
			gunzip > ${FIRMWARE_FILE}
	echo "${FIRMWARE_SHA256} ${FIRMWARE_FILE}" | sha256sum -c || die "firmware checksum mismatch"
}

src_install() {
	insinto "/lib/firmware/${FIRMWARE_DIR}"
	doins $FIRMWARE_FILE
}

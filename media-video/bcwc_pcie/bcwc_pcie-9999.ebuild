# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=6

inherit eutils linux-mod git-r3

DESCRIPTION="Reverse engineered Linux driver for the Broadcom 1570 PCIe webcam"
HOMEPAGE="https://github.com/patjak/bcwc_pcie"
SRC_URI=""

EGIT_REPO_URI="https://github.com/patjak/bcwc_pcie"

LICENSE=""
SLOT="0"
KEYWORDS="~amd64"

DEPEND=""
RDEPEND="
	media-video/apple_facetimehd_firmware
	media-libs/libv4l
${DEPEND}"

BUILD_TARGETS="all"
MODULE_NAMES="facetimehd()"
CONFIG_CHECK="VIDEO_DEV VIDEOBUF2_CORE VIDEOBUF2_DMA_SG"

src_unpack() {
	kernel_is -ge 4 8 && {
		EGIT_BRANCH="master"
	}
	git-r3_src_unpack
}

src_prepare() {
	default
	sed -i "s#KDIR := /lib/modules/\$(KVERSION)/build#KDIR := ${KERNEL_DIR}#" Makefile
}

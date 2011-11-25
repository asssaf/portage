# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=4

inherit eutils versionator

DESCRIPTION="Palm WebOS SDK with Mojo and Enyo Application Framework and
			 emulator to develop HP Pre and Touchpad applications"
HOMEPAGE="http://developer.palm.com/"

MY_VER="$(get_version_component_range 1-3)-svn519870-pho669"
SRC_URI="http://cdn.downloads.palm.com/sdkdownloads/${PV}/sdkBinaries/palm-sdk_${MY_VER}_i386.deb"

LICENSE="PalmSDK"
SLOT="0"
KEYWORDS="~amd64 ~x86 -*"
MY_LINGUAS="linguas_de linguas_it linguas_pt_BR linguas_ru linguas_sv"
IUSE=${MY_LINGUAS}

SLOT="3.0.4"

RDEPEND="|| (
		app-emulation/virtualbox-bin
		app-emulation/virtualbox
	)
	>=virtual/jre-1.5
	x86? (
		net-libs/libproxy
		net-libs/libsoup:2.4
		net-libs/libsoup-gnome:2.4
		net-libs/webkit-gtk
		x11-libs/gtk+:2
	)"

QA_PRESTRIPPED_x86="
	opt/PalmSDK/0.1/bin/palminspector
	opt/PalmSDK/0.1/bin/proxy"
QA_PRESTRIPPED_amd64="${QA_PRESTRIPPED_x86}
	opt/PalmSDK/0.1/lib/libproxy.so
	opt/PalmSDK/0.1/lib/libproxy.so.0
	opt/PalmSDK/0.1/lib/libproxy.so.0.0.0
	opt/PalmSDK/0.1/lib/libproxy/0.2.3/plugins/envvar.so
	opt/PalmSDK/0.1/lib/libproxy/0.2.3/plugins/file.so
	opt/PalmSDK/0.1/lib/libproxy/0.2.3/plugins/gnome.so
	opt/PalmSDK/0.1/lib/libproxy/0.2.3/plugins/kde.so"

src_unpack() {
	unpack ${A}
	unpack ./data.tar.gz
	mkdir ${S} || die
	mv opt ${S} || die
}

src_prepare() {
	local my_linguas
	for my_linguas in ${MY_LINGUAS} ; do
		use ${my_linguas} && continue
		rm -rf "opt/PalmSDK/0.1/share/locale/${my_linguas#linguas_}" || die
	done

	rm -rf opt/PalmSDK/0.1/lib/lib{soup,webkit}* || die

	if use x86 ; then
		rm -rf opt/PalmSDK/0.1/lib/libproxy* || die
	fi
}

src_install() {
	local my_bin
	for my_bin in $(find opt/PalmSDK/0.1/bin -maxdepth 1 -type f) ; do
		dosym "/${my_bin}" "/opt/bin/$(basename "${my_bin}")"
	done

	insinto /opt/PalmSDK
	doins -r opt/PalmSDK/0.1
	fperms -R a+x /opt/PalmSDK/0.1/bin

	dosym /opt/PalmSDK/0.1 opt/PalmSDK/Current

	newicon "${FILESDIR}/${PN}-emulator.png" palm-emulator.png
	make_desktop_entry /opt/bin/palm-emulator "Palm Mojo SDK Emulator" palm-emulator Development

	if use amd64 ; then
		ewarn "palminspector does not work on amd64 due to missing 32bit libraries "
		ewarn "libenchant.so.1 libicu{data,i18n,uc}.so.38 and libgnutls.so.13."
		ewarn "The execute bit will be removed to silence revdep-rebuild."
		ewarn "You can obtain these by using portage2.2 and multilib overlay."
		ewarn "See http://github.com/sjnewbury/multilib-overlay for details."
#		fperms a-x /opt/PalmSDK/0.1/bin/palminspector
	fi
}

pkg_postinst() {
	if ! grep 'localhost' /etc/hosts | grep -s -q '127.0.0.1' ; then
		ewarn 'Add "127.0.0.1 localhost" to your /etc/hosts'
	fi
	if ! grep -s -q '127.0.0.1 qemu' /etc/hosts ; then
		ewarn 'Add "127.0.0.1 qemu" to your /etc/hosts'
	fi
	if ! grep -s -q '192.168.2.101 device' /etc/hosts ; then
		ewarn 'Add something like "192.168.2.101 device" to your /etc/hosts'
	fi
	elog 'Do not forget to add your account to the vboxusers group!'
}

# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI="2"

inherit java-pkg-2

MY_PN=${PN%%-bin}
MY_PV=${PV/_pre/-milestone-}
MY_PV=${MY_PV/_rc/-rc-}
MY_P="${MY_PN}-${MY_PV}"

DESCRIPTION="Build Tool for Java"
SRC_URI="http://gradle.artifactoryonline.com/gradle/distributions/${MY_P}-all.zip"
HOMEPAGE="http://www.gradle.org/"
LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~x86 ~amd64"

DEPEND="app-arch/zip"
RDEPEND=">=virtual/jdk-1.5"

IUSE="source doc examples"

S="${WORKDIR}/${MY_P}"


src_unpack() {
	unpack ${A}
}


src_install() {
	local gradle_home="${ROOT}/usr/share/${PN}"

	insinto "${gradle_home}"

	# source
	if use source ; then
		java-pkg_dosrc src/*
	fi

	# docs
	if use doc ; then
		java-pkg_dojavadoc docs
	fi

	# examples
	if use examples ; then
		java-pkg_doexamples samples
	fi

	# jars
	cd lib
	for jar in *.jar; do 
		java-pkg_newjar ${jar} ${jar}
	done

	# plugin jars
	insinto "${gradle_home}/lib/plugins"
	doins plugins/*

	java-pkg_dolauncher "gradle" --main org.gradle.launcher.GradleMain --java_args "-Dgradle.home=${gradle_home}"
}

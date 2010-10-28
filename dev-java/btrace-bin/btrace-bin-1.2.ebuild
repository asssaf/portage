EAPI="2"

inherit java-pkg-2

MY_PN=${PN%%-bin}

DESCRIPTION="BTrace is a safe, dynamic tracing tool for the Java platform"
HOMEPAGE="http://kenai.com/projects/btrace/pages/Home"
SRC_URI="http://kenai.com/projects/${MY_PN}/downloads/download/releases%252Frelease-${PV}%252F${PN}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE="doc examples"

RDEPEND=">=virtual/jdk-1.6
	>=dev-java/sun-jdk-1.6"


#S="${WORKDIR}"

src_install() {
	local btrace_home="${ROOT}/usr/share/${PN}"

	if use doc ; then
		java-pkg_dojavadoc docs
	fi

	if use examples ; then
		java-pkg_doexamples samples
	fi

	insinto ${btrace_home}

	cd build
	java-pkg_dojar btrace-agent.jar
	java-pkg_dojar btrace-boot.jar
	java-pkg_dojar btrace-client.jar

	java-pkg_dolauncher "btrace" --main com.sun.btrace.client.Main --java_args "-Dcom.sun.btrace.probeDescPath=. -Dcom.sun.btrace.dumpClasses=false -Dcom.sun.btrace.debug=false -Dcom.sun.btrace.unsafe=false"
	java-pkg_dolauncher "btracec" --main com.sun.btrace.compiler.Compiler

	# install a package specific environment file that adds tools.jar to the classpath
	insinto "${ROOT}/etc/java-config-2/launcher.d"
	newins "${FILESDIR}/launcher.d-${PN}" "${PN}"
}

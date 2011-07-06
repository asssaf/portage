# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2"

DISTUTILS_SRC_TEST="setup.py"

inherit distutils

DESCRIPTION="Review Board tools"
HOMEPAGE="http://www.reviewboard.org"
SRC_URI="http://downloads.reviewboard.org/releases/${PN}/${PV}/${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="|| ( >=dev-lang/python-2.6 dev-python/simplejson )"
RDEPEND="${DEPEND}"

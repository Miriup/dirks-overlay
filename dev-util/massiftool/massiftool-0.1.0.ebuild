# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit qmake-utils

DESCRIPTION="massiftool is a simple, lightweight tool to examine and visualize (create graphs from) the output of valgrind's massif, written in C++/Qt"
HOMEPAGE="http://massiftool.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P/-/_}.tar.gz"

LICENSE=""
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=""
RDEPEND="${DEPEND}"

src_configure() {
	eqmake4 TARGET_PATH=${ED}/usr
	}

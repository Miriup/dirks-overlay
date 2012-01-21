# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=4

DESCRIPTION="KDE SSH Tunnel Manager"
HOMEPAGE="http://sourceforge.net/projects/kstm/"
SRC_URI="mirror://sourceforge/kstm/${PN}${PV}-source.tar.gz"
S=${WORKDIR}/${PN}

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

DEPEND="x11-libs/qt-core"
RDEPEND="${DEPEND}"

src_compile() {
	emake -j5 QMAKE=/usr/bin/qmake
}

src_install() {
	dobin kstm
}

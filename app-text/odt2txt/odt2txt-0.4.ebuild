# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

DESCRIPTION="command-line tool which extracts the text out of OpenDocument Texts produced by OpenOffice.org, StarOffice, KOffice and others."
HOMEPAGE="http://stosberg.net/odt2txt/"
SRC_URI="http://stosberg.net/odt2txt/${P}.tar.gz"

LICENSE="GPLv2"
SLOT="0"
KEYWORDS="~amd64 ~x86-macos"
IUSE=""

DEPEND=""
RDEPEND=""

src_install() {
	insinto /usr/bin
	doins odt2txt
}

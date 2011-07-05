# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="3"

inherit git autotools

DESCRIPTION=""
HOMEPAGE=""
SRC_URI=""
EGIT_REPO_URI="git://git.torproject.org/git/torsocks"

LICENSE=""
SLOT="0"
KEYWORDS="~x86-macos"
IUSE=""

DEPEND=""
RDEPEND="${DEPEND}"

src_prepare() {
	eautoreconf
}

src_compile() {
	emake
}

src_install() {
	emake install
}

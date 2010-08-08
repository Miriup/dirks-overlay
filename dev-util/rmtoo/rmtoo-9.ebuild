# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2"

inherit eutils

DESCRIPTION="rmtoo is an open source requirement management tool. It is intended for programmers (no GUI). "
HOMEPAGE="http://rmtoo.gnu4u.org/"
SRC_URI="mirror://sourceforge/rmtoo/${P}.tar.gz"

LICENSE="GPLv3"
SLOT="0"
KEYWORDS="~x86-macos"
IUSE=""

DEPEND="
dev-python/git-python
>=dev-lang/python-2.5
sci-visualization/gnuplot
"
RDEPEND="${DEPEND}"
#

src_prepare() {
	epatch ${FILESDIR}/${P}-system-path.patch
}

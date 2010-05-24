# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="prefix"

DESCRIPTION=""
HOMEPAGE="http://w3.man.torun.pl/%7Emakler/prog/pg2xbase/"
SRC_URI="http://www.klaban.torun.pl/prog/pg2xbase/${P}.tgz"

LICENSE=""
SLOT="0"
KEYWORDS="~x86-macos"
IUSE=""

DEPEND=">=dev-db/xbase-2.0.0 
|| ( >=dev-db/libpq-2.2.8 dev-libs/libpqxx )
"
#RDEPEND=""

src_unpack() {
	unpack ${A}
	#epatch "${FILESDIR}/${P}-darwin.patch" || die
	cd ${S}
	patch Makefile "${FILESDIR}/${P}-darwin.patch" || die
}

src_compile() {
	emake INCLUDES="-I${EPREFIX}/usr/include -I${EPREFIX}/usr/include/xbase -I${EPREFIX}/usr/include/postgresql/internal -I${EPREFIX}/usr/include/postgresql/server" || die
}

src_install() {
	dodir /usr/man/man1
	dodir /usr/share/${PN}
	emake prefix=${ED}/usr mandir=${ED}/usr/share/man install
}

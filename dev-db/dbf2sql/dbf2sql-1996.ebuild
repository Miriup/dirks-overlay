# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="prefix"

inherit toolchain-funcs

APPGEN_VERSION=0.2pl2

DESCRIPTION="Converts DBase III compatible DBF files to an SQL script"
HOMEPAGE=""
SRC_URI="ftp://ftp:example.org@ftp.mcc.ac.uk/pub/linux/ALPHA/AppGEN/appgen-${APPGEN_VERSION}.tar.gz"

LICENSE="unknown"
SLOT="0"
KEYWORDS="~x86-macos"
IUSE=""

DEPEND=""
RDEPEND=""

src_compile() {
	cd ${WORKDIR}/AppGEN/src/tools/
	CC=$(tc-getCC)
	$CC ${CFLAGS} dbf2sql.c -o dbf2sql
}

src_install() {
	dobin ${WORKDIR}/AppGEN/src/tools/dbf2sql
}

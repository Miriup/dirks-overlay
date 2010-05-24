# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="prefix"

GLIBC_RELEASE_VER=2.6.1

DESCRIPTION="mntent part of glibc for use on other operating systems"
HOMEPAGE=""
SRC_URI="mirror://gnu/glibc/glibc-${GLIBC_RELEASE_VER}.tar.bz2"

LICENSE="GPL"
SLOT="0"
KEYWORDS="~x86-macos"
IUSE=""

DEPEND=""
RDEPEND=""

src_compile() {
	cd ${P}/misc
	gcc -c -o mntent.o mntent.c
	gcc -c -o mntent_r.o mntent_r.c
	gcc -l -o libmntent.dylib
}

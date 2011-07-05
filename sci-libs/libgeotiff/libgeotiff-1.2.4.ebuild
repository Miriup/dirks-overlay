# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-libs/libgeotiff/libgeotiff-1.2.4.ebuild,v 1.2 2007/09/01 20:10:31 nerdboy Exp $

EAPI="prefix"

inherit autotools eutils flag-o-matic

DESCRIPTION="Library for reading TIFF files with embedded tags for geographic (cartographic) information"
HOMEPAGE="http://remotesensing.org/geotiff/geotiff.html"
SRC_URI="ftp://ftp.remotesensing.org/pub/geotiff/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~mips ~ppc ~ppc64 ~sparc ~x86 ~x86-macos"
IUSE="doc python jpeg proj"

DEPEND="virtual/libc
	>=media-libs/tiff-3.7.0
	sci-libs/proj
	jpeg? ( media-libs/jpeg )
	doc? ( app-doc/doxygen )"

WANT_AUTOCONF="latest"

src_compile() {
	if [[ ${CHOST} == *-darwin* ]]; then
	epatch ${FILESDIR}/${P}-soname-macos.patch || die "epatch failed"
	eprefixify ${S}/configure.in
	else
	epatch ${FILESDIR}/${P}-soname.patch || die "epatch failed"
	fi
	filter-ldflags "-Wl,-O1"
	elibtoolize
	eautoconf

	local conf_arg
	conf_arg="--with-libtiff=${EPREFIX}/usr --with-zip=${EPREFIX}/usr"

	if use jpeg; then
		$conf_arg="${conf_arg} --with-jpeg=${EPREFIX}/usr"
	fi
	if use proj; then
		$conf_arg="${conf_arg} --with-proj=${EPREFIX}/usr"
	fi

	econf $conf_arg || die "econf failed"
	emake -j1 || die "emake failed"

	if use doc; then
	    make dox || die "make dox failed"
	fi
}

src_install() {
	emake DESTDIR="${D}" install || die "make install failed"

	exeinto /usr/bin
	doexe bin/makegeo
	use python && doexe csv/*.py

	dodoc README
	newdoc csv/README README.csv
	use doc && dohtml docs/api/*
}

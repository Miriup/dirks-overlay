# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/newt/newt-0.50.35-r4.ebuild,v 1.8 2007/06/26 01:54:41 mr_bones_ Exp $

EAPI="prefix"

inherit python toolchain-funcs

DESCRIPTION="Redhat's Newt windowing toolkit development files"
SRC_URI="http://koto.mynetix.de/gentoo/${P}.tar.gz"
HOMEPAGE="http://www.redhat.com"
SLOT="0"
LICENSE="LGPL-2"
KEYWORDS="~x86 ~ppc ~sparc ~hppa ~amd64 ~alpha ppc64 ~x86-macos"
IUSE=""
DEPEND="=sys-libs/slang-1*
	>=dev-libs/popt-1.6
	dev-lang/python
	elibc_uclibc? ( sys-libs/ncurses )"

src_unpack() {
	unpack ${A}
	# bug 73850
	if use elibc_uclibc; then
		sed -i -e 's:-lslang:-lslang -lncurses:g' ${S}/Makefile.in
	fi

	# use the correct compiler...
	sed -i -e 's:gcc:$(CC):g' ${S}/Makefile.in

	# avoid make cleaning up some intermediate files
	# as it would rebuild them during install :-(
	echo >>${S}/Makefile.in
	echo '$(LIBNEWT): $(LIBOBJS)' >>${S}/Makefile.in
}

src_compile() {
	python_version
	econf || die
	# not parallel safe
	emake -j1 PYTHONVERS="python${PYVER}" RPM_OPT_FLAGS="${CFLAGS}" CC="$(tc-getCC)" || die "make failure"
}

src_install () {
	python_version
	# the RPM_OPT_FLAGS="ERROR" is there to catch a build error
	# if it fails, that means something in src_compile() didn't build properly
	# not parallel safe
	emake -j1 prefix="${D}/usr" PYTHONVERS="python${PYVER}" RPM_OPT_FLAGS="ERROR" install || die "make install failed"
	dodoc CHANGES COPYING peanuts.py popcorn.py tutorial.sgml
	dosym libnewt.so.${PV} /usr/lib/libnewt.so.0.50
}

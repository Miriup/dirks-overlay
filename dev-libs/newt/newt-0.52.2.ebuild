# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/newt/newt-0.52.2.ebuild,v 1.4 2007/06/26 01:54:41 mr_bones_ Exp $

EAPI="prefix"

inherit python toolchain-funcs eutils rpm autotools

# Revision of the RPM. Shouldn't affect us, as we're just grabbing the source
# tarball out of it
RPMREV="9"

DESCRIPTION="Redhat's Newt windowing toolkit development files"
HOMEPAGE="http://www.redhat.com/"
SRC_URI="mirror://fedora/development/source/SRPMS/${P}-${RPMREV}.src.rpm"

LICENSE="LGPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~ppc ~ppc64 ~sparc ~x86 ~x86-macos"
IUSE="gpm tcl"

RDEPEND="=sys-libs/slang-1*
	>=dev-libs/popt-1.6
	dev-lang/python
	elibc_uclibc? ( sys-libs/ncurses )
	gpm? ( sys-libs/gpm )
	tcl? ( =dev-lang/tcl-8.4* )"
DEPEND="${RDEPEND}"

src_unpack() {
	rpm_src_unpack
	cd "${S}"

	# bug 73850
	if use elibc_uclibc; then
		sed -i -e 's:-lslang:-lslang -lncurses:g' ${S}/Makefile.in
	fi

	epatch "${FILESDIR}"/${P}-scrollbars.patch
	epatch "${FILESDIR}"/${P}-pgupdown-crash.patch
	epatch "${FILESDIR}"/${P}-screensize.patch
	epatch "${FILESDIR}"/${P}-cbtpos.patch
	epatch "${FILESDIR}"/${P}-focus.patch
	epatch "${FILESDIR}"/${P}-cursor.patch
	epatch "${FILESDIR}"/${P}-colors.patch
	epatch "${FILESDIR}"/${P}-pyexample.patch
	epatch "${FILESDIR}"/${P}-dwchar.patch

	if ! use tcl; then
		epatch "${FILESDIR}"/${P}-notcl.patch
	fi

	epatch "${FILESDIR}"/${P}-slang.patch
	# dirk@miriup.de: I know conditional patches suck, but an unconditional 
	# one would convert it into using automake.
	[[ ${CHOST} == *-apple-darwin* ]] && epatch "${FILESDIR}"/${P}-darwin.patch
	eautoconf
}

src_compile() {
	python_version

	econf \
		--with-libiconv-prefix=${EPREFIX}/usr \
		--with-libintl-prefix=${EPREFIX}/usr \
		$(use_with gpm gpm-support)

	# not parallel safe
	emake \
		PYTHONVERS="python${PYVER}" \
		RPM_OPT_FLAGS="${CFLAGS} -I${EPREFIX}/usr/include -L${EPREFIX}/usr/lib -D__unix__" \
		|| die "emake failed"
}

src_install () {
	python_version
	# the RPM_OPT_FLAGS="ERROR" is there to catch a build error
	# if it fails, that means something in src_compile() didn't build properly
	# not parallel safe
	emake \
		prefix="${ED}/usr" \
		libdir="${ED}/usr/$(get_libdir)" \
		PYTHONVERS="python${PYVER}" \
		RPM_OPT_FLAGS="ERROR" \
		install || die "make install failed"
	dodoc peanuts.py popcorn.py tutorial.sgml
	doman whiptail.1

	# Don't know if it's needed but it was here before so leaving /peper
	dosym libnewt.so.0.52.1 /usr/$(get_libdir)/libnewt.so.0.52
}

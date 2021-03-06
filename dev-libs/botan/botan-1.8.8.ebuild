# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/botan/botan-1.8.8.ebuild,v 1.4 2009/12/28 21:18:01 maekke Exp $

EAPI="2"

inherit eutils multilib toolchain-funcs prefix

MY_PN="Botan"
MY_P="${MY_PN}-${PV}"
DESCRIPTION="A C++ crypto library"
HOMEPAGE="http://botan.randombit.net/"
SRC_URI="http://files.randombit.net/botan/${MY_P}.tgz"

KEYWORDS="~amd64-linux ~ia64-linux ~x86-linux ~x86-macos"
SLOT="0"
LICENSE="BSD"
IUSE="bzip2 gmp ssl threads zlib"

S="${WORKDIR}/${MY_P}"

RDEPEND="bzip2? ( >=app-arch/bzip2-1.0.5 )
	zlib? ( >=sys-libs/zlib-1.2.3 )
	gmp? ( >=dev-libs/gmp-4.2.2 )
	ssl? ( >=dev-libs/openssl-0.9.8g )"

DEPEND="${RDEPEND}
	>=dev-lang/python-2.4"

src_prepare() {
	epatch "${FILESDIR}/${P}-use_negative_lea_displacement.patch"
	epatch "${FILESDIR}"/${P}-install_name.patch
	eprefixify src/build-data/cc/gcc.txt
}

src_configure() {
	local disable_modules="proc_walk,unix_procs,cpu_counter"

	if ! useq threads; then
		disable_modules="${disable_modules},pthreads"
	fi

	# Enable v9 instructions for sparc64
	if [[ "${PROFILE_ARCH}" = "sparc64" ]]; then
		CHOSTARCH="sparc32-v9"
	else
		CHOSTARCH="${CHOST%%-*}"
	fi

	cd "${S}"
	elog "Disabling modules: ${disable_modules}"

	# I'm copied from perl-5.10.1.ebuild
	case ${CHOST} in
		*-freebsd*)   osname="freebsd" ;;
		*-dragonfly*) osname="dragonfly" ;;
		*-netbsd*)    osname="netbsd" ;;
		*-openbsd*)   osname="openbsd" ;;
		*-darwin*)    osname="darwin" ;;
		*-solaris*)
			osname="solaris"
			# solaris2.9 has /lib/libgdbm.so.2 and /lib/libgdbm.so.3,
			# but no linkable /lib/libgdbm.so.
			# This might apply to others too, but seen on solaris only yet.
			myconf -Dignore_versioned_solibs
			;;
		*-aix*)       osname="aix" ;;
		*-hpux*)      osname="hpux" ;;
		*-irix*)
			osname="irix"
			myconf -Dcc="cc -n32 -mips4"
			use ithreads && myconf -Dlibs="-lm -lpthread" || myconf -Dlibs="-lm"
			;;
		*-interix*)   osname='interix' ;;
		*-mint*)      osname="freemint" ;;
		*)            osname="linux" ;;
	esac

	# FIXME: We might actually be on *BSD or OS X...
	./configure.py \
		--prefix="${ED}/usr" \
		--libdir=/$(get_libdir) \
		--docdir=/share/doc/ \
		--cc=gcc \
		--os=${osname} \
		--cpu=${CHOSTARCH} \
		--with-endian="$(tc-endian)" \
		--with-tr1=system \
		$(use_with bzip2) \
		$(use_with gmp gnump) \
		$(use_with ssl openssl) \
		$(use_with zlib) \
		--disable-modules=${disable_modules} \
		|| die "configure.py failed"
}

src_compile() {
	emake CXX="$(tc-getCXX)" AR="$(tc-getAR) crs" LIB_OPT="${CXXFLAGS}" MACH_OPT="" || die "emake failed"
}

src_test() {
	chmod -R ugo+rX "${S}"
	emake CXX="$(tc-getCXX)" CHECK_OPT="${CXXFLAGS}" check || die "emake check failed"
	LD_LIBRARY_PATH="${S}" ./check --validate || die "Validation tests failed"
}

src_install() {
	emake install || die "emake install failed"
	sed -i -e "s:${D%/}::g" "${ED}usr/bin/botan-config" "${ED}usr/$(get_libdir)/pkgconfig/botan-1.8.pc" || die "sed failed"
	# HFS+ is case-insensitive and does treat Botan and botan alike. 
	# mv will report an error.
	[[ ${CHOST} == *-darwin* ]] ||
	mv "${ED}usr/share/doc/Botan-${PV}" "${ED}usr/share/doc/${PF}" || die "Renaming of directory failed"
}

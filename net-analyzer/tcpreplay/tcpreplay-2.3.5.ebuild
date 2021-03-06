# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-analyzer/tcpreplay/tcpreplay-2.3.5.ebuild,v 1.5 2007/07/02 14:42:27 peper Exp $

EAPI="prefix"

DESCRIPTION="replay saved tcpdump or snoop files at arbitrary speeds"
HOMEPAGE="http://tcpreplay.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"
RESTRICT="mirror"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64-linux ~x86-linux ~x86-macos"
IUSE="debug"

DEPEND=">=net-libs/libnet-1.1.1
	net-libs/libpcap
	net-analyzer/tcpdump"

src_compile() {
	econf \
		$(use_with debug) \
		|| die "econf failed"
	emake CFLAGS="${CFLAGS}" || die "emake failed"
}

src_test() {
	whoami
	if hasq userpriv "${FEATURES}"; then
		ewarn "Some tested disabled due to FEATURES=userpriv"
		ewarn "For a full test as root - make -C ${S}/test"
		make -C test tcpprep || die "self test failed - see ${S}/test/test.log"
	else
		make test || \
			die "self test failed - see ${S}/test/test.log"
	fi

}

src_install() {
	make \
		prefix=${ED}/usr \
		MAN8DIR=${ED}/usr/share/man/man8 \
		MAN1DIR=${ED}/usr/share/man/man1 \
		install \
		|| die "install failed"
	dodoc Docs/*
}

# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-analyzer/tcpreplay/tcpreplay-1.4.6.ebuild,v 1.6 2006/02/16 00:05:08 jokey Exp $

EAPI="prefix"

DESCRIPTION="replay saved tcpdump or snoop files at arbitrary speeds"
HOMEPAGE="http://tcpreplay.sourceforge.net/"
SRC_URI="mirror://sourceforge/tcpreplay/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="x86 ~x86-macos"
IUSE=""

DEPEND=">=net-libs/libnet-1.1.1
	net-libs/libpcap"

src_compile() {
	econf || die
	emake CFLAGS="${CFLAGS}" -j1 || die
}

src_install() {
	emake \
		prefix=${ED}/usr \
		MAN8DIR=${ED}/usr/share/man/man8 \
		MAN1DIR=${ED}/usr/share/man/man1 \
		install \
		|| die "install failed"
	dodoc Docs/*
}

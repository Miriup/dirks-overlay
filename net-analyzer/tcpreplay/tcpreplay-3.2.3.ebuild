# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-analyzer/tcpreplay/tcpreplay-3.2.3.ebuild,v 1.2 2008/02/15 23:58:17 cla Exp $

EAPI="prefix"

DESCRIPTION="replay saved tcpdump or snoop files at arbitrary speeds"
HOMEPAGE="http://tcpreplay.synfin.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"
RESTRICT="mirror"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64-linux ~x86-linux ~x86-macos"
IUSE="debug pcapnav"

DEPEND=">=net-libs/libnet-1.1.1
	net-libs/libpcap
	net-analyzer/tcpdump
	pcapnav? ( net-libs/libpcapnav )"

src_compile() {
	econf \
		$(use_enable debug) \
		--with-libpcap=${EPREFIX}/usr \
		--with-libnet=${EPREFIX}/usr \
		--with-tcpdump=${EPREFIX}/usr/bin/tcpdump \
		|| die "econf failed"
	emake || die "emake failed"
}

src_test() {
	whoami
	if hasq userpriv "${FEATURES}"; then
		ewarn "Some tested disabled due to FEATURES=userpriv"
		ewarn "For a full test as root - make -C ${S}/test"
		make -C test tcpprep || die "self test failed - see ${S}/test/test.log"
	else
		make test || {
			ewarn "Note, that some tests require eth0 iface to be UP." ;
			die "self test failed - see ${S}/test/test.log" ; }
	fi
}

src_install() {
	make DESTDIR="${D}" install || die "emake install failed"
	rm "${ED}"/usr/bin/man2html
	dodoc docs/{CHANGELOG,CREDIT,HACKING,TODO}
}

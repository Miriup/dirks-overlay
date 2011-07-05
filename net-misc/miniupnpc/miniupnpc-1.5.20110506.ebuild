# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/miniupnpd/miniupnpd-1.5.ebuild,v 1.1 2011/01/21 16:09:48 gurligebis Exp $

EAPI=2
inherit eutils linux-info toolchain-funcs

#MY_PV=1.5
#S="${WORKDIR}/${PN}-${MY_PV}"

DESCRIPTION="MiniUPnP IGD Daemon"
SRC_URI="http://miniupnp.free.fr/files/${P}.tar.gz"
HOMEPAGE="http://miniupnp.free.fr/"

LICENSE="BSD"
SLOT="0"
KEYWORDS=" ~x86-macos"
IUSE=""

RDEPEND=">=net-firewall/iptables-1.4.6
	sys-apps/lsb-release
	>=sys-kernel/linux-headers-2.6.31"
DEPEND="${RDEPEND}
	sys-apps/util-linux
	"

src_compile() {
	emake CC="$(tc-getCC)" || die "emake failed"
}

src_install () {
	einstall PREFIX="${ED}" STRIP="true" || die "einstall failed"
}

pkg_postinst() {
	elog "Please correct the external interface in the top of the two"
	elog "scripts in /etc/miniupnpd and edit the config file in there too"
}

# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=3

inherit rpm versionator

DESCRIPTION=""
HOMEPAGE="http://social.wakoopa.com"

MY_P=${P/_p/-}

SRC_URI="
amd64? ( http://apt.wakoopa.com/${MY_P}.x86_64.rpm )"
#x86? ( http://apt.wakoopa.com/${MY_P}.i686.rpm )"

RESTRICT="strip mirror"

LICENSE=""
SLOT="0"
KEYWORDS="~amd64"
IUSE="doc"

DEPEND="app-arch/rpm2targz"
RDEPEND="${DEPEND}
!app-misc/wakoopa"

src_install() {
	# Binaries (doing separate to allow some magic to happen)
	exeinto /usr/bin
	doexe usr/bin/wakoopa

	# architecture independent files
	cp -pr usr/share ${D}/usr/share/

	# Remove docs if not requested.
	use doc || rm -R ${D}/usr/share/doc

	# Install revdep-rebuild script
	insinto /etc/revdep-rebuild
	doins ${FILESDIR}/99${PN}.revdep-rebuild
}

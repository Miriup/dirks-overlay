# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="prefix"

DESCRIPTION="FUSE FTP Filessytem"
HOMEPAGE="http://wiki.thiesen.org/page/Fuseftp"
SRC_URI="http://perl.thiesen.org/fuseftp/fuseftp-0.8.tar.gz"

LICENSE="GPL"
SLOT="0"
KEYWORDS="~x86-macos"
IUSE=""

DEPEND=""
RDEPEND=""

src_compile() {
	econf
	emake
}

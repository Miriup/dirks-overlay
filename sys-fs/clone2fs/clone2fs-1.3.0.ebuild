# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

DESCRIPTION="Clone2fs copies an ext2/ext3 file system to another volume or an image file."
HOMEPAGE="http://freecode.com/projects/clone2fs"
SRC_URI="http://www.mr511.de/software/${P}.tar.gz"

LICENSE="GPL"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

DEPEND="sys-fs/e2fsprogs sys-libs/e2fsprogs-libs"
RDEPEND="${DEPEND}"

src_compile() {
	emake
}

src_install() {
	emake sbindir=${D}/sbin install
}

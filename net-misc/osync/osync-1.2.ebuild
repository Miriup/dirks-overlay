# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

DESCRIPTION="A robust two way (bidirectional) file sync script based on rsync with fault tolerance, ACL support and time control"
HOMEPAGE="http://www.netpower.fr/osync"
SRC_URI="https://github.com/deajan/osync/archive/v${PV}.tar.gz -> ${P}.tar.gz"
EGIT_REPO_URI="https://github.com/deajan/osync.git"

LICENSE="BSD-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=""
RDEPEND="${DEPEND}"

src_install() {
	FAKEROOT="${ED}" ./install.sh
}

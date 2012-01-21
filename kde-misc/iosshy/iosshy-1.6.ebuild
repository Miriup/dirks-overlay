# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=4
PYTHON_DEPEND="*"

inherit git-2 distutils

DESCRIPTION="Desktop tool to quickly setup SSH tunnels and automatically execute commands that make use of them"
HOMEPAGE="https://github.com/mtorromeo/iosshy"
EGIT_REPO_URI="git://github.com/mtorromeo/iosshy.git"
EGIT_COMMIT="v${PV}"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

DEPEND=""
RDEPEND="${DEPEND} kde-base/pykde4 >=dev-python/PyQt4-4.6 dev-python/paramiko
dev-python/setproctitle dev-python/pycrypto dev-python/python-keyring"


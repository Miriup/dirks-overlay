# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6
PYTHON_COMPAT=(python2_7)

inherit git-r3 distutils-r1

DESCRIPTION=""
HOMEPAGE=""
[ "${PV}" == 9999 ] && EGIT_COMMIT="v.${PV}" || SRC_URI="https://github.com/joe42/CloudFusion/archive/v.${PV}.tar.gz -> ${P}.tar.gz"
EGIT_REPO_URI="git://github.com/joe42/CloudFusion.git"

LICENSE=""
SLOT="0"
KEYWORDS=""
IUSE=""

DEPEND=""
RDEPEND="${DEPEND}"

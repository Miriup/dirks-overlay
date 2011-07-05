# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2"

inherit distutils subversion

ESVN_REPO_URI="http://g-pypi.googlecode.com/svn/trunk"

DESCRIPTION="Create Python ebuilds for Gentoo by querying The Python Package Index"
HOMEPAGE="http://code.google.com/p/g-pypi/"
#SRC_URI="http://pypi.python.org/packages/source/g/${PN}/${P}.tar.gz"
LICENSE="GPL-2"
# A decent 9999 ebuild would no KEYWORDS!
KEYWORDS="~amd64 ~x86 ~x86-macos"
SLOT="0"
IUSE="test"
DEPEND="dev-python/setuptools
	test? ( dev-python/nose )"
RDEPEND="dev-python/setuptools
	dev-python/pygments
	dev-python/cheetah
	app-portage/gentoolkit
	dev-python/configobj
	dev-python/yolk"

# Patching be better done in ESVN_PATCHES, but we do it here to use the
# originally submitted patch. dirk@miriup.de
src_prepare() {
	cd ${S}/g_pypi
	epatch "${FILESDIR}/portage_utils.patch"
	cd ..
	epatch "${FILESDIR}"/${P}-ebuild-tmpl.patch
}

src_test() {
	PYTHONPATH=. "${python}" setup.py nosetests || die "tests failed"
}


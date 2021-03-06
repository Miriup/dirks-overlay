# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/g-pypi/g-pypi-0.3.ebuild,v 1.2 2012/07/23 20:25:28 floppym Exp $

EAPI="4"
PYTHON_DEPEND="2:2.6"
SUPPORT_PYTHON_ABIS="1"
RESTRICT_PYTHON_ABIS="2.5 3.*"
DISTUTILS_SRC_TEST="nosetests"

inherit git-2 distutils

DESCRIPTION="Manages ebuilds using information from Python Package Index"
HOMEPAGE="https://github.com/iElectric/g-pypi"
#SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz"
EGIT_REPO_URI="git@github.com:Miriup/${PN}.git"

LICENSE="BSD-2"
KEYWORDS="~amd64 ~x86"
SLOT="0"
IUSE="doc test"

DEPEND="
	dev-python/setuptools
	doc? (
		dev-python/sphinx
	)
	test? (
		dev-python/mock
		dev-python/mocker
		dev-python/scripttest
	)
"
RDEPEND="
	app-portage/gentoolkit
	app-portage/gentoolkit-dev
	app-portage/metagen
	dev-python/argparse
	>=dev-python/jaxml-3.02
	dev-python/setuptools
	dev-python/jinja
	dev-python/pygments
	dev-python/sphinxcontrib-googleanalytics
	dev-python/unittest2
	dev-python/yolk
"

PYTHON_MODNAME="gpypi"

src_compile() {
	distutils_src_compile
	use doc && emake -C docs html
}

src_install() {
	distutils_src_install
	use doc && dohtml -r docs/build/html/*
}

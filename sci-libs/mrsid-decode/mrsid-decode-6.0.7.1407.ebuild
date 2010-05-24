# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="prefix"

DESCRIPTION=""
HOMEPAGE="http://www.lizardtech.com/developer/"
SRC_URI="Geo_DSDK-${PV}.darwin8.universal.gccA40.tar"
RESTRICT="fetch"

LICENSE="other"
SLOT="4.0"
KEYWORDS="~x86-macos"
IUSE="doc"

DEPEND=""
RDEPEND=""

src_install() {
	cd "${WORKDIR}/Geo_DSDK-${PV}"

	dobin bin/*
	if use doc
	then
		#dodoc doc/*
		insinto /usr/share/doc/${PF}/${_E_DOCDESTTREE_}
		doins -r doc/*
	fi

	insinto /usr
	doins -r include

	dolib lib/Release/*
}

# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=4

DIGIKAMPN=digikam

KDE_LINGUAS=""

CMAKE_MIN_VERSION=2.8
KDE_MINIMAL="4.5"

inherit kde4-base

MY_P="${DIGIKAMPN}-${PV/_/-}"

DESCRIPTION="Qt/C++ wrapper around LibFace to perform face recognition and detection"
HOMEPAGE="http://www.digikam.org/"
SRC_URI="mirror://sourceforge/${DIGIKAMPN}/${MY_P}.tar.bz2"

LICENSE="GPL-2"
KEYWORDS="~amd64 ~x86"
IUSE=""
SLOT=4

# this beta temporarily forces the use of the bundled media-libs/libface

DEPEND="
	>=media-libs/opencv-2.1
"
RDEPEND=${DEPEND}

S=${WORKDIR}/${MY_P}/extra/${PN}

src_prepare() {
	kde4-base_src_prepare
	epatch "${FILESDIR}"/${PN}-2.0.0-unused-cvcam.patch
}

src_configure() {
	mycmakeargs=(
		-DFORCED_UNBUNDLE=ON
	)
	mycmakeargs+=("--debug-output")
	kde4-base_src_configure
}

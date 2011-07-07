# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=3

DESCRIPTION=""
HOMEPAGE="http://social.wakoopa.com"

MY_P=

SRC_URI="
amd64? ( http://apt.wakoopa.com/${PN}_${PV}_x86_64.tar.gz )
x86? ( http://apt.wakoopa.com/${PN}_${PV}_i686.tar.gz )"

RESTRICT="strip mirror"

LICENSE=""
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

DEPEND="app-arch/rpm2targz"
RDEPEND="${DEPEND}"

src_install() {
	use amd64 && arch=x86_64
	use x86 && arch=i686
	cd ${WORKDIR}/${PN}_${PV}_${arch}
	exeinto /usr/bin
	doexe wakoopa
	insinto /usr/share/pixmaps/wakoopa
	doins pixmaps/*
}

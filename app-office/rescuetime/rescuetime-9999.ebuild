# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=4

inherit pax-utils

if [ ${PV} -eq 9999 ]
then
	MY_PV=current
else
	MY_PV=${PV}
fi

DESCRIPTION="RescueTime is a service that provides the user with the knowledge of how they spend their time while on the computer."
HOMEPAGE="http://help.rescuetime.com/discussions/beta/7-rescuetime-for-linux-beta-tester-feedback"
BASE_URI="https://www.rescuetime.com/installers/${PN}_${MY_PV}_"
SRC_URI="amd64? ( ${BASE_URI}amd64.deb )
x86? ( ${BASE_URI}i386.deb )
"

LICENSE=""
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="hardened"
RESTRICT="mirror"

# xprintidle, libqtgui4, libqt4-sql-sqlite 
# If you're having problems with xprintidle, use layman to add the bgo-overlay
# (see http://bgo.zugaina.org/).
RDEPEND="=dev-qt/qtgui-4* 
x11-libs/libXScrnSaver
x11-libs/libxcb
x11-libs/libXdmcp
x11-libs/libXau
dev-libs/libbsd
x11-libs/libX11
x11-libs/libXext
x11-apps/xprop
>=sys-libs/glibc-2.14"

S=${WORKDIR}

src_unpack() {
	unpack "${A}"
	cd "${WORKDIR}"
	ebegin Unpacking data.tar.xz
	xzcat data.tar.xz | tar x
	eend
}

src_configure() {
	# hardened voodoo
	pax-mark M usr/bin/rescuetime
}

src_install() {
	dobin usr/bin/rescuetime
}

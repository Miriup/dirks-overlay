# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=4

DESCRIPTION="RescueTime is a service that provides the user with the knowledge of how they spend their time while on the computer."
HOMEPAGE="http://help.rescuetime.com/discussions/beta/7-rescuetime-for-linux-beta-tester-feedback"
BASE_URI="https://www.rescuetime.com/installers/${PN}_${PV}_"
SRC_URI="amd64? ( ${BASE_URI}amd64.deb )
x86? ( ${BASE_URI}i386.deb )
"

LICENSE=""
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""
RESTRICT="mirror"

# xprintidle, libqtgui4, libqt4-sql-sqlite 
# If you're having problems with xprintidle, use layman to add the bgo-overlay
# (see http://bgo.zugaina.org/).
DEPEND=""
RDEPEND="=x11-libs/qt-gui-4* x11-libs/qt-sql[sqlite] x11-misc/xprintidle >=sys-libs/glibc-2.14"

src_unpack() {
	mkdir "${WORKDIR}/${P}"
	cd "${WORKDIR}/${P}"
	unpack "${A}"
	unpack "./data.tar.gz"
}

src_install() {
	dobin ./usr/bin/rescuetime
}

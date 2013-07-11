# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=4

inherit rpm

if [ ${PV} -eq 9999 ]
then
	MY_PV=current
else
	MY_PV=9999
fi

DESCRIPTION="RescueTime is a service that provides the user with the knowledge of how they spend their time while on the computer."
HOMEPAGE="http://help.rescuetime.com/discussions/beta/7-rescuetime-for-linux-beta-tester-feedback"
BASE_URI="https://www.rescuetime.com/installers/${PN}_${MY_PV}_"
SRC_URI="amd64? ( ${BASE_URI}amd64.rpm )
x86? ( ${BASE_URI}i386.rpm )
"

LICENSE=""
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="hardened"
RESTRICT="mirror"

# xprintidle, libqtgui4, libqt4-sql-sqlite 
# If you're having problems with xprintidle, use layman to add the bgo-overlay
# (see http://bgo.zugaina.org/).
DEPEND="app-arch/rpm2targz hardened? ( sys-apps/paxctl )"
RDEPEND="=dev-qt/qtgui-4* dev-qt/qtsql[sqlite] x11-misc/xprintidle >=sys-libs/glibc-2.14"

src_unpack() {
	mkdir "${WORKDIR}/${P}"
	cd "${WORKDIR}/${P}"
	rpm_src_unpack "${A}"
}

src_configure() {
	# hardened voodoo
	[[ -x /sbin/paxctl ]] && /sbin/paxctl -cm usr/bin/rescuetime 
}

src_install() {
	dobin ./usr/bin/rescuetime
}

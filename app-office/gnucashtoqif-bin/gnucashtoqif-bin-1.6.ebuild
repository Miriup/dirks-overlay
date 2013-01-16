# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=4

inherit eutils java-pkg-2

DESCRIPTION="This Java program converts a GnuCash XML file into a QIF file."
HOMEPAGE="http://gnucashtoqif.sourceforge.net/"
SRC_URI="mirror://sourceforge/gnucashtoqif/${PV}/GnuCashToQIF-${PV}.jar"

LICENSE="public-domain"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

DEPEND="!app-office/gnucashtoqif >=virtual/jre-1.3 >=app-office/gnucash-1.6.0"
RDEPEND="${DEPEND}"

src_unpack() {
	mkdir "${S}"
	cp "${DISTDIR}/${A}" "${S}"
}

src_compile() {
	cd "${S}"
	mv GnuCashToQIF-${PV}.jar ${PN}.jar
}

src_install() {
	java-pkg_dojar ${PN}.jar
	java-pkg_dolauncher 
}

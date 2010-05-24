# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-php/PEAR-PEAR/PEAR-PEAR-1.6.2.ebuild,v 1.1 2007/10/22 22:33:47 jokey Exp $

EAPI="prefix"

inherit depend.php

ARCHIVE_TAR="1.3.2"
CONSOLE_GETOPT="1.2.3"
STRUCTURES_GRAPH="1.0.2"
XML_RPC="1.5.1"
PEAR="${PV}"

[[ -z "${PEAR_CACHEDIR}" ]] && PEAR_CACHEDIR="${EPREFIX}/var/cache/pear"

KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~ppc ~ppc64 ~s390 ~sh ~sparc ~x86 ~x86-macos"

DESCRIPTION="PEAR Base System (PEAR, Archive_Tar, Console_Getopt, Structures_Graph, XML_RPC)."
HOMEPAGE="http://pear.php.net/"
SRC_URI="http://pear.php.net/get/Archive_Tar-${ARCHIVE_TAR}.tgz
		http://pear.php.net/get/Console_Getopt-${CONSOLE_GETOPT}.tgz
		http://pear.php.net/get/Structures_Graph-${STRUCTURES_GRAPH}.tgz
		http://pear.php.net/get/XML_RPC-${XML_RPC}.tgz
		http://pear.php.net/get/PEAR-${PEAR}.tgz"
LICENSE="LGPL-2.1 PHP"
SLOT="0"
IUSE="x86-macos"

# we depend on a recent sandbox version to mitigate problems users
# have been experiencing
DEPEND="dev-lang/php
	!x86-macos? (>=sys-apps/sandbox-1.2.17) "
RDEPEND="dev-lang/php"

S=${WORKDIR}

pkg_setup() {
	has_php

	# we check that PHP was compiled with the correct USE flags
	if [[ ${PHP_VERSION} == "4" ]] ; then
		require_php_with_use cli pcre expat zlib
	else
		require_php_with_use cli pcre xml zlib
	fi
}

src_unpack() {
	unpack ${A}
	cd "${WORKDIR}"/PEAR-${PV}
	epatch "${FILESDIR}"/${PV}-accept-encoding-bug_12116.patch # PEAR bug #12116
	epatch "${FILESDIR}/eprefix.patch"
	eprefixify scripts/pear.sh scripts/peardev.sh scripts/pecl.sh 
}

src_install() {
	require_php_cli

	# Prevent SNMP related sandbox violoation.
	addpredict /usr/share/snmp/mibs/.index
	addpredict /var/lib/net-snmp/

	mkdir -p PEAR/XML/RPC

	# Install PEAR Package.
	cp -r PEAR-${PEAR}/OS PEAR/
	cp -r PEAR-${PEAR}/PEAR PEAR/
	cp PEAR-${PEAR}/PEAR.php PEAR/PEAR.php
	cp PEAR-${PEAR}/System.php PEAR/System.php

	# Prepare /usr/bin/pear script.
	mv PEAR-${PEAR}/scripts/pearcmd.php PEAR/pearcmd.php
	sed -i "s:@pear_version@:${PEAR}:g" PEAR/pearcmd.php || die "sed failed"
	mv PEAR-${PEAR}/scripts/pear.sh PEAR-${PEAR}/scripts/pear
	sed -i -e "s:@php_bin@:${PHPCLI}:g" \
		-e "s:@bin_dir@:${EPREFIX}/usr/bin:g" \
		-e "s:@php_dir@:${EPREFIX}/usr/share/php:g" \
		-e "s:-d output_buffering=1:-d output_buffering=1 -d memory_limit=32M:g" PEAR-${PEAR}/scripts/pear || die "sed failed"

	# Prepare /usr/bin/peardev script.
	mv PEAR-${PEAR}/scripts/peardev.sh PEAR-${PEAR}/scripts/peardev
	sed -i -e "s:@php_bin@:${PHPCLI}:g" \
		-e "s:@bin_dir@:${EPREFIX}/usr/bin:g" \
		-e "s:@php_dir@:${EPREFIX}/usr/share/php:g" PEAR-${PEAR}/scripts/peardev || die "sed failed"

	# Prepare /usr/bin/pecl script.
	mv PEAR-${PEAR}/scripts/peclcmd.php PEAR/peclcmd.php
	sed -i "s:@pear_version@:${PEAR}:g" PEAR/peclcmd.php || die "sed failed"
	mv PEAR-${PEAR}/scripts/pecl.sh PEAR-${PEAR}/scripts/pecl
	sed -i -e "s:@php_bin@:${PHPCLI}:g" \
		-e "s:@bin_dir@:${EPREFIX}/usr/bin:g" \
		-e "s:@php_dir@:${EPREFIX}/usr/share/php:g" PEAR-${PEAR}/scripts/pecl || die "sed failed"

	# Prepare PEAR/Dependency2.php.
	sed -i "s:@PEAR-VER@:${PEAR}:g" PEAR/PEAR/Dependency2.php || die "sed failed"

	# Install Archive_Tar Package.
	cp -r Archive_Tar-${ARCHIVE_TAR}/Archive PEAR/

	# Install Console_Getopt Package.
	cp -r Console_Getopt-${CONSOLE_GETOPT}/Console PEAR/

	# Install Structures_Graph Package.
	cp -r Structures_Graph-${STRUCTURES_GRAPH}/Structures PEAR/

	# Install XML_RPC Package.
	cp XML_RPC-${XML_RPC}/RPC.php PEAR/XML/RPC.php
	cp XML_RPC-${XML_RPC}/Server.php PEAR/XML/RPC/Server.php

	# Finalize installation.
	cd PEAR
	insinto /usr/share/php
	doins -r Archive Console OS PEAR Structures XML *.php
	cd ../PEAR-${PEAR}/scripts
	dobin pear peardev pecl

	insinto /etc
	doins "${FILESDIR}/pear.conf"
	sed -i -e "s|s:PHPCLILEN:\"PHPCLI\"|s:${#PHPCLI}:\"${PHPCLI}\"|g" \
		-e "s|s:CACHEDIRLEN:\"CACHEDIR\"|s:${#PEAR_CACHEDIR}:\"${PEAR_CACHEDIR}\"|g" "${ED}/etc/pear.conf" || die "sed failed"

	einfo eprefixify''ing the PEAR configuration
	PHP_PEAR_INSTALL_DIR=${ED}/usr/share/php ${ED}/usr/bin/pear -C "${ED}/etc/pear.conf" config-set ext_dir ${EXT_DIR} system
	for OPTION in bin_dir doc_dir php_dir cache_dir data_dir test_dir; do
		#ORIG_SETTING=`${PHPCLI} PEAR/peclcmd.php -C "${WORKDIR}/pear.conf" config-get ${OPTION} 2>/dev/null`
		ORIG_SETTING=`PHP_PEAR_INSTALL_DIR=${ED}/usr/share/php ${ED}/usr/bin/pear -C "${ED}/etc/pear.conf" config-get ${OPTION} system 2>/dev/null`
		einfo Changing ${OPTION} from ${ORIG_SETTING} to "${EPREFIX}${ORIG_SETTING#${EPREFIX}}"
		PHP_PEAR_INSTALL_DIR=${ED}/usr/share/php ${ED}/usr/bin/pear -C "${ED}/etc/pear.conf" config-set ${OPTION} "${EPREFIX}${ORIG_SETTING#${EPREFIX}}" system
	done
	
	einfo The configuration is now:
	set -x
	ls -li "${ED}/etc/pear.conf" 
	dodir /tmp
	PHP_PEAR_INSTALL_DIR=${ED}/usr/share/php ktrace -f ${ED}/tmp/pear.trace ${ED}/usr/bin/pear -C "${ED}/etc/pear.conf" config-show system
	set +x

	keepdir "${PEAR_CACHEDIR#${EPREFIX}}"
	fperms 755 "${PEAR_CACHEDIR#${EPREFIX}}"
}

pkg_preinst() {
	rm -f "${EROOT}/etc/pear.conf"
}

pkg_postinst() {
	pear clear-cache

	# Update PEAR/PECL channels as needed, add new ones to the list if needed
	pearchans="pear.php.net pecl.php.net components.ez.no pear.phpdb.org pear.phing.info pear.symfony-project.com pear.phpunit.de pear.php-baustelle.de pear.zeronotice.org pear.phpontrax.com"

	for chan in ${pearchans} ; do
		pear channel-discover ${chan}
		pear channel-update ${chan}
	done
}

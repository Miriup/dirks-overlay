# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6
PYTHON_COMPAT=(python2_7)

inherit distutils-r1

[ "${PV}" == 9999 ] && inherit git-r3

DESCRIPTION=""
HOMEPAGE=""
[ "${PV}" == 9999 ] && \
	EGIT_REPO_URI="git://github.com/joe42/CloudFusion.git" || \
	SRC_URI="https://github.com/joe42/CloudFusion/archive/v.${PV}.tar.gz -> ${P}.tar.gz"

LICENSE=""
SLOT="0"
KEYWORDS=""
IUSE="sikuli google_drive google_storage captchas"

DEPEND="${DEPEND}"
RDEPEND="${DEPEND}
google_drive? ( dev-libs/libffi )
sys-fs/fuse
sikuli? ( media-libs/opencv )
captchas? ( dev-python/pycurl dev-libs/libxml2[python] app-text/tesseract )
dev-python/psutil
dev-python/profilehooks
dev-python/PyDrive
dev-python/tinydav
dev-python/sh
net-misc/gsutil
dev-python/ntplib
dev-python/argparse
dev-python/nose
"

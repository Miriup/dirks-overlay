# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=3

inherit cmake-utils git-2

DESCRIPTION="Dolphin dropbox plugin"
HOMEPAGE="http://trichard-kde.blogspot.com/2010/12/introducing-dropbox-integration-for.html"
EGIT_REPO_URI="git://anongit.kde.org/scratch/trichard/dolphin-box-plugin.git"

LICENSE=""
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

DEPEND=""
RDEPEND="net-misc/dropbox kde-base/dolphin"


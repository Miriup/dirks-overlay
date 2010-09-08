# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=2

#VIM_PLUGIN_VIM_VERSION="7.0"
inherit vim-plugin

DESCRIPTION="vim plugin: "
HOMEPAGE="http://www.vim.org/scripts/script.php?script_id=1542"
LICENSE=""
KEYWORDS="~amd64"
IUSE=""
SRC_URI="http://www.vim.org/scripts/download_script.php?src_id=10872 -> ${P}.vim"
S=${WORKDIR}

VIM_PLUGIN_HELPFILES=""
VIM_PLUGIN_HELPTEXT=""
VIM_PLUGIN_HELPURI=""
VIM_PLUGIN_MESSAGES=""

src_unpack() {
	mkdir "${S}/plugin" || die
	cp "${DISTDIR}/${P}.vim" "${S}/plugin/${PN}.vim" || die
}

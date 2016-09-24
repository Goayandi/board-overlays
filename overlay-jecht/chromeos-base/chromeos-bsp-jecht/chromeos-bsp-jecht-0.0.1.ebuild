# Copyright 2014 The Chromium OS Authors. All rights reserved.
# Distributed under the terms of the GNU General Public License v2

EAPI=4

inherit appid

DESCRIPTION="Ebuild which pulls in any necessary ebuilds as dependencies
or portage actions."

LICENSE="BSD-Google"
SLOT="0"
KEYWORDS="-* amd64 x86"
S="${WORKDIR}"

# Add dependencies on other ebuilds from within this board overlay
RDEPEND="
	chromeos-base/chromeos-bsp-baseboard-jecht
	media-libs/go2001-fw
	media-libs/media-rules
"
DEPEND="${RDEPEND}"

src_install() {
	doappid "{CC1EA699-3C85-8357-6E30-AC92FD975C8D}" "CHROMEBOX"
}

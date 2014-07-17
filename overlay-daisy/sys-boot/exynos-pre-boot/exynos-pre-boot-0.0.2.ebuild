# Copyright (c) 2012 The Chromium OS Authors. All rights reserved.
# Distributed under the terms of the GNU General Public License v2

EAPI=4

DESCRIPTION="Binary pre-bootloader for ironhide"
SRC_URI="http://commondatastorage.googleapis.com/chromeos-localmirror/distfiles/${PF}.tbz2"

# This package requires no license information to be displayed (not even
# Google-TOS). Do not use this license without a contractual reason.
LICENSE="Proprietary-Binary"
SLOT="0"
KEYWORDS="arm"
IUSE=""

S=${WORKDIR}/${PN}

src_install() {
	# The tbz2 file contains the following:
	# exynos-pre-boot/firmware/E5250.nbl1.bin
	insinto /firmware
	newins firmware/*.bin u-boot.bl1.bin
}

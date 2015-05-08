# Copyright (c) 2013 The Chromium OS Authors. All rights reserved.
# Distributed under the terms of the GNU General Public License v2

EAPI=4

CROS_WORKON_COMMIT="8673713b3c32db3c9a220e262484613b928be3ac"
CROS_WORKON_TREE="1e0383a06609251b6253556d0ddd01214b0867db"
CROS_WORKON_PROJECT="chromiumos/third_party/kernel"
CROS_WORKON_LOCALNAME="kernel/v3.10"
CROS_WORKON_BLACKLIST="1"

inherit cros-workon cros-kernel2 eutils

DESCRIPTION="Chrome OS Kernel-nyan_freon"

KEYWORDS="*"

DEPEND="!sys-kernel/chromeos-kernel-next
	!sys-kernel/chromeos-kernel
"
RDEPEND="${DEPEND}"

src_prepare() {
	cros-workon_src_prepare
	epatch ${FILESDIR}/*.patch
}

src_configure() {
	cros-kernel2_src_configure
}

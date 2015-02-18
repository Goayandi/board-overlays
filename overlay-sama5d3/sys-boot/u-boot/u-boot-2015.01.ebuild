# Copyright 2015 The Chromium OS Authors. All rights reserved.
# Distributed under the terms of the GNU General Public License v2

EAPI=4

inherit toolchain-funcs flag-o-matic

# The tarball for this package can be re-created from the upstream
# repository with the following commands:
#   $ PN=u-boot PV=2013.07 P=${PN}-${PV}
#   $ git clone git://git.denx.de/${PN}.git ${P}
#   $ cd ${P}
#   $ git checkout v${PV}
#   $ rm -rf .git
#   $ cd ..
#   $ tar cf ${P}.tar ${P}
#   $ bzip2 ${P}.tar
#
# TODO(jrbarnette):  Really, we want to eliminate this ebuild
# altogether, and rely on the standard Chromium OS U-Boot ebuild.
# http://crbug.com/302022

DESCRIPTION="Das U-Boot for Chrome OS on beaglebone"
HOMEPAGE="http://www.denx.de/wiki/U-Boot/WebHome"
SRC_URI="ftp://ftp.denx.de/pub/u-boot/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="arm"

umake() {
	env -u ARCH emake CROSS_COMPILE="${CHOST}-" "HOSTCC=${BUILD_CC}" "$@"
}

src_prepare() {
	epatch "${FILESDIR}"/*.patch
}

src_configure() {
	export LDFLAGS=$(raw-ldflags)
	tc-export BUILD_CC
	umake sama5d3_xplained_mmc_defconfig
}

src_compile() {
	umake
}

src_install() {
	insinto /firmware
	doins boot.bin u-boot.img
}

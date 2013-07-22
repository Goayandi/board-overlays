# Copyright (c) 2013 The Chromium OS Authors. All rights reserved.
# Distributed under the terms of the GNU General Public License v2

EAPI=4

inherit tegra-bct eutils

DESCRIPTION="Puppy BCT file"
HOMEPAGE="http://src.chromium.org"

LICENSE="BSD-3"
SLOT="0"
KEYWORDS="arm"
IUSE="bootflash-spi bootflash-emmc dalmore"
REQUIRED_USE="
	bootflash-spi? ( !bootflash-emmc )
	bootflash-emmc? ( !bootflash-spi )
"
PROVIDE="virtual/tegra-bct"

S=${WORKDIR}

src_configure() {
	local board=$(usex dalmore dalmore venice)

	if use bootflash-emmc; then
		TEGRA_BCT_FLASH_CONFIG="${board}/emmc.cfg"
	elif use bootflash-spi; then
		TEGRA_BCT_FLASH_CONFIG="${board}/spi.cfg"
	fi

	TEGRA_BCT_SDRAM_CONFIG="${board}/sdram.cfg"

	TEGRA_BCT_ODM_DATA_CONFIG="${board}/odmdata.cfg"

	TEGRA_BCT_CHIP_FAMILY="t114"

	tegra-bct_src_configure
}

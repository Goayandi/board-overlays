# Copyright 2015 The Chromium OS Authors. All rights reserved.
# Distributed under the terms of the GNU General Public License v2

EAPI=4

inherit appid udev

DESCRIPTION="Minnie bsp (meta package to pull in driver/tool deps)"

LICENSE="BSD-Google"
SLOT="0"
KEYWORDS="-* arm"
IUSE="cheets"

RDEPEND=""
DEPEND=""


S=${WORKDIR}

src_install() {
	if use cheets; then
		doappid "{A3C55EA3-785B-B911-F08A-E4ADC386445F}" "CHROMEBOOK"
	else
		doappid "{432FF9F1-4D2E-7E74-6F98-32E56E904BFB}" "CHROMEBOOK" # veyron-minnie
	fi

	dosbin "${FILESDIR}/battery_cut_off.sh"
	dosbin "${FILESDIR}/board_charge_battery.sh"
	dosbin "${FILESDIR}/board_factory_reset.sh"
	dosbin "${FILESDIR}/board_factory_wipe.sh"
	dosbin "${FILESDIR}/display_wipe_message.sh"

}

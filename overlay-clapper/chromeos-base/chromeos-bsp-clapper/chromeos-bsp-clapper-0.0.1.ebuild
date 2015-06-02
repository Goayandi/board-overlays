# Copyright (c) 2013 The Chromium OS Authors. All rights reserved.
# Distributed under the terms of the GNU General Public License v2

EAPI=4

inherit appid udev

DESCRIPTION="Clapper private bsp (meta package to pull in driver/tool deps)"

LICENSE="BSD-Google"
SLOT="0"
KEYWORDS="-* amd64 x86"
IUSE=""

RDEPEND="
	chromeos-base/chromeos-accelerometer-init
	chromeos-base/chromeos-touch-config-clapper
	chromeos-base/ec-utils
	sys-kernel/linux-firmware
	media-gfx/ply-image
"
DEPEND="${RDEPEND}"
S="${WORKDIR}"

src_install() {
	doappid "{BBCEB6C1-5567-09B4-1619-DAD125AC892D}" "CHROMEBOOK"

	# Install platform specific config files for power_manager.
	udev_dorules "${FILESDIR}/92-powerd-overrides.rules"
	insinto "/usr/share/power_manager/board_specific"
	doins "${FILESDIR}"/powerd_prefs/*

	# Battery cut-off
	dosbin "${FILESDIR}/battery_cut_off.sh"
	dosbin "${FILESDIR}/board_factory_wipe.sh"
	dosbin "${FILESDIR}/board_factory_reset.sh"
	dosbin "${FILESDIR}/board_charge_battery.sh"

	insinto "/usr/share/factory/images"
	doins "${FILESDIR}/remove_ac.png"
	doins "${FILESDIR}/cutting_off.png"
	doins "${FILESDIR}/cutoff_failed.png"
	doins "${FILESDIR}/charging.png"
	doins "${FILESDIR}/connect_ac.png"
}

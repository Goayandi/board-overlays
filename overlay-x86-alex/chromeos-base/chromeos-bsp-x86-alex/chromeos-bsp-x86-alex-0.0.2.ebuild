# Copyright (c) 2013 The Chromium OS Authors. All rights reserved.
# Distributed under the terms of the GNU General Public License v2

EAPI="4"

inherit appid cros-audio-configs udev

DESCRIPTION="Board-specific packages for x86-alex"
HOMEPAGE="http://src.chromium.org"
SRC_URI=""

LICENSE="BSD-Google"
SLOT="0"
KEYWORDS="-* amd64 x86"
IUSE=""

DEPEND="!chromeos-base/light-sensor"

S="${WORKDIR}"

src_install() {
	doappid "{C776D42E-287A-435E-8BA7-E770BD30B46D}" "CHROMEBOOK"

	# Install platform-specific ambient light sensor configuration.
	udev_dorules "${FILESDIR}/99-light-sensor.rules"
	exeinto $(udev_get_udevdir)
	doexe "${FILESDIR}/light-sensor-set-multiplier.sh"

	# Install board-specific info
	insinto "/etc/laptop-mode/conf.d/board-specific"
	doins "${FILESDIR}/intel-hda-powersave.conf"

	# Install audio configs.
	local audio_config_dir="${FILESDIR}/audio-config"
	install_audio_configs x86-alex "${audio_config_dir}"
}

# Copyright 2015 The Chromium OS Authors. All rights reserved.
# Distributed under the terms of the GNU General Public License v2

EAPI=4

inherit appid udev

DESCRIPTION="Ebuild which pulls in any necessary ebuilds as dependencies
or portage actions."

LICENSE="BSD-Google"
SLOT="0"
KEYWORDS="-* arm64 arm"
IUSE="cheets"
S="${WORKDIR}"

# Add dependencies on other ebuilds from within this board overlay
DEPEND=""
RDEPEND="${DEPEND}
	chromeos-base/chromeos-accelerometer-init
	chromeos-base/ec-utils
	media-libs/media-rules
	sys-apps/ethtool
"

src_install() {
	if use cheets; then
		doappid "{CEAE875E-929A-9522-8C07-013C13A20456}" "CHROMEBOOK"
	else
		doappid "{8D0990C8-904D-45FD-ACEB-DCCAD82EC66E}" "CHROMEBOOK"
	fi

	# install ucm config files
	insinto /usr/share/alsa/ucm
	local ucm_config="${FILESDIR}/ucm-config"
	if [[ -d "${ucm_config}" ]] ; then
		doins -r "${ucm_config}"/*
	fi

	# Install platform specific config files for power_manager.
	insinto "/usr/share/power_manager/board_specific"
	doins "${FILESDIR}"/powerd_prefs/*

	# Install rules to enable WoWLAN on startup.
	udev_dorules "${FILESDIR}/99-mwifiex-wowlan.rules"
}

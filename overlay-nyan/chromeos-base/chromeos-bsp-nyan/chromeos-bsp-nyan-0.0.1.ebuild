# Copyright (c) 2014 The Chromium OS Authors. All rights reserved.
# Distributed under the terms of the GNU General Public License v2

EAPI=4

inherit appid

DESCRIPTION="Nyan bsp (meta package to pull in driver/tool dependencies)"

LICENSE="BSD-Google"
SLOT="0"
KEYWORDS="-* arm"
IUSE="opengles tegra-ldk variant_build"

DEPEND="sys-boot/chromeos-bootimage"
RDEPEND="
	!variant_build? ( chromeos-base/chromeos-touch-config-nyan )
	sys-kernel/tegra_lp0_resume
	tegra-ldk? (
		opengles? ( media-libs/openmax media-libs/openmax-codecs )
		x11-drivers/tegra-drivers
	)
	sys-apps/daisydog
"

S=${WORKDIR}

src_install() {
	# Variants of nyan will have their own appids
	if ! use variant_build; then
		doappid "{334FF5FA-CEE5-7688-1C73-78CE7F5B24A9}"
	fi

	# Override default CPU clock speed governor
	insinto "/etc/laptop-mode/conf.d/board-specific"
	doins "${FILESDIR}/cpufreq.conf"
	# Enable the Tegra CPU auto-hotplug feature
	insinto "/etc/laptop-mode/conf.d/board-specific"
	doins "${FILESDIR}/nv-cpu-auto-hotplug.conf"
	exeinto "/usr/share/laptop-mode-tools/modules"
	doexe "${FILESDIR}/nv-cpu-auto-hotplug"

	# Install platform specific config files for power_manager.
	insinto "/usr/share/power_manager/board_specific"
	doins "${FILESDIR}"/powerd_prefs/*

	# Install upstart script for setting CPU governors.
	insinto "/etc/init"
	doins "${FILESDIR}/tegra_governors.conf"
}

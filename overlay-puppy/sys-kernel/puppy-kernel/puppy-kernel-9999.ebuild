# Copyright (c) 2013 The Chromium OS Authors. All rights reserved.
# Distributed under the terms of the GNU General Public License v2

EAPI=4

CROS_WORKON_REPO="git://nv-tegra.nvidia.com"
CROS_WORKON_PROJECT="chromeos/kernel"
CROS_WORKON_LOCALNAME="../partner_private/nvidia-kernel"
CROS_WORKON_BLACKLIST="1"

# This must be inherited *after* EGIT/CROS_WORKON variables defined
inherit cros-workon cros-kernel2

DESCRIPTION="Chrome OS Kernel-puppy"

LICENSE="GPL-2"
KEYWORDS="~arm"

DEPEND="!sys-kernel/chromeos-kernel-next
	!sys-kernel/chromeos-kernel
"
RDEPEND="${DEPEND}"

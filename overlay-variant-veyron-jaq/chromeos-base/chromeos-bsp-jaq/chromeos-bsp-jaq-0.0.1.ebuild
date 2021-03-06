# Copyright 2015 The Chromium OS Authors. All rights reserved.
# Distributed under the terms of the GNU General Public License v2

EAPI=4

inherit appid

DESCRIPTION="Jaq bsp (meta package to pull in driver/tool deps)"

LICENSE="BSD-Google"
SLOT="0"
KEYWORDS="-* arm"

DEPEND="!<chromeos-base/chromeos-bsp-jaq-private-0.0.1"
RDEPEND=""

S=${WORKDIR}

src_install() {
	doappid "{6D2E4D56-A22C-2F8F-7127-DA90A65F85E1}" "CHROMEBOOK" # veyron-jaq
}

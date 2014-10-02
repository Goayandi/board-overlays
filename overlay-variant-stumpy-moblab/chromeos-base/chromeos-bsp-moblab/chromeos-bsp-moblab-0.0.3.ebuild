# Copyright (c) 2013 The Chromium OS Authors. All rights reserved.
# Distributed under the terms of the GNU General Public License v2

EAPI="4"

inherit appid user

DESCRIPTION="Ebuild which pulls in any necessary ebuilds as dependencies or portage actions"

LICENSE="BSD-Google"
SLOT="0"
KEYWORDS="*"
IUSE=""

# These packages are meant to set up the Chromium OS Basic environment to
# properly handle the services required by the lab infrastructure.
RDEPEND="
	chromeos-base/chromeos-init
	chromeos-base/chromeos-test-testauthkeys
	chromeos-base/openssh-server-init
	chromeos-base/jabra-vold
	net-ftp/tftp-hpa
	net-misc/dhcp
	net-misc/rsync
"

# Chromium OS Autotest Server and Devserver Deps.
RDEPEND="${RDEPEND}
	chromeos-base/autotest-server
	chromeos-base/devserver
"

DEPEND=""

S=${WORKDIR}

pkg_setup() {
	enewgroup moblab
	enewuser moblab
}

src_install() {
	doappid "{0A54D104-EC0D-450D-8588-FB106B2C6703}"

	insinto /etc/init
	doins "${FILESDIR}"/init/*.conf

	insinto /etc/apache2/modules.d
	doins "${FILESDIR}/moblab-apache-settings.conf"

	insinto /etc/dhcp
	doins "${FILESDIR}/dhcpd-moblab.conf"

	insinto "/usr/share/power_manager/board_specific"
	doins "${FILESDIR}/avoid_suspend_when_headphone_jack_plugged"
	doins "${FILESDIR}/require_usb_input_device_to_suspend"

	insinto "/usr/share/power_manager/"
	doins "${FILESDIR}/disable_idle_suspend"

	# TODO (crbug.com/348172) - This is a temporary fix to not wipe
	# stateful when booting off USB as a base image.
	dodir "/mnt/stateful_partition"
	touch "${D}/mnt/stateful_partition/.developer_mode"

	# Create the mount point for external storage.
	dodir "/mnt/moblab"

	# Give moblab full sudo access.
	# NOTE: this is a temporary hack to allow FAFT tests
	# to run on moblab using servoV2. Once we fully
	# move over to servoV3, we should reduce this to
	# the previous sudo access.
	# See chromium:394593
	insinto /etc/sudoers.d
	echo "moblab ALL=NOPASSWD: ALL" > moblab-all
	echo "apache ALL = NOPASSWD: /sbin/reboot" > apache-reboot
	insopts -m600
	doins moblab-all
	doins apache-reboot

	insinto /root
	newins "${FILESDIR}/bash_profile" .bash_profile
}

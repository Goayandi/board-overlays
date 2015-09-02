#!/bin/sh -e
#
# Copyright 2015 The Chromium OS Authors. All rights reserved.
# Use of this source code is governed by a BSD-style license that can be
# found in the LICENSE file.
#
# Jaq specific post factory wipe script. This will
#   1. clean the activate date in VPD.
#   2. battery cut-off, shutdown, or return to caller (for reboot)

/usr/sbin/activate_date --clean
# make sure the cached vpd log file has been removed so that the the next reboot
# will re-generate it in /etc/init/vpd-log.conf.
VPD_2_0="/var/log/vpd_2.0.txt"
rm -f $VPD_2_0
sync
sleep 3

/usr/sbin/board_charge_battery.sh

# this script is called by clobber-state
# battery cut-off after factory wipe-out
/usr/sbin/battery_cut_off.sh
# reboot after return to clobber-state(default)

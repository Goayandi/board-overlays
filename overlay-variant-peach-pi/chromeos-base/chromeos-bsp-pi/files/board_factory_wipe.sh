#!/bin/sh -e
#
# Copyright (c) 2013 The Chromium OS Authors. All rights reserved.
# Use of this source code is governed by a BSD-style license that can be
# found in the LICENSE file.
#
# Pi specific post factory wipe script. This will
#   1. battery cut-off, shutdown, or return to caller (for reboot)

# make sure the cached vpd log file has been removed so that the the next reboot
# will re-generate it in /etc/init/vpd-log.conf.
VPD_2_0="/var/log/vpd_2.0.txt"
rm -f $VPD_2_0
sync
sleep 3

# this script is called by clobber-state
for WIPE_OPTION in "$@"; do
  if [ "$WIPE_OPTION" = "battery_cut_off" ]; then
    # battery cut-off after factory wipe-out
    /usr/sbin/battery_cut_off.sh
  elif [ "$WIPE_OPTION" = "shutdown" ]; then
    # shutdown after factory wipe-out
    /sbin/shutdown -h now
  fi
done
# reboot after return to clobber-state(default)

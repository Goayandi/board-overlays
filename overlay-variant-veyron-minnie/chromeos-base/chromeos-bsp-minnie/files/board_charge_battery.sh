#!/bin/bash
#
# Copyright 2015 The Chromium OS Authors. All rights reserved.
# Use of this source code is governed by a BSD-style license that can be
# found in the LICENSE file.
#
# This script checks the battery level is high enough for shipping. If not,
# it asks for AC power and waits for the battery to charge.
#

BATTERY_PATH="/sys/class/power_supply/bq27500-0"
MIN_LEVEL=45
DISPLAY_MESSAGE="/usr/sbin/display_wipe_message.sh"

get_percentage() {
  CHARGE_NOW=$(cat "${BATTERY_PATH}"/charge_now)
  CHARGE_FULL=$(cat "${BATTERY_PATH}"/charge_full)
  echo $((100 * ${CHARGE_NOW} / ${CHARGE_FULL}))
}

if [[ $(get_percentage) -le $MIN_LEVEL ]]; then
  # Ask for AC power
  if [ -z "$(ectool battery | grep AC_PRESENT)" ]; then
    "${DISPLAY_MESSAGE}" "connect_ac"
    while [ -z "$(ectool battery | grep AC_PRESENT)" ]; do
      sleep 0.5;
    done
  fi

  # Wait for battery to charge to MIN_LEVEL
  while [[ $(get_percentage) -le $MIN_LEVEL ]]; do
    "${DISPLAY_MESSAGE}" "charging" "$(get_percentage)" "${MIN_LEVEL}"
    sleep 1
  done
fi

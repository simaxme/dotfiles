#!/usr/bin/env bash

TRUSTED_DEVICES="$(bluetoothctl devices Trusted)"
AUTO_CONNECT_DEVICES="$(echo "$TRUSTED_DEVICES" | grep -E '^Device.*(iPhone|iPad)')"
AUTO_CONNECT_DEVICES_MAC="$(echo "$AUTO_CONNECT_DEVICES" | awk '{print $2}')"

echo "$AUTO_CONNECT_DEVICES_MAC" | xargs -d '\n' -I {} -P 0 bluetoothctl connect "{}"

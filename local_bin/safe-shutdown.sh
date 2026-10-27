#!/usr/bin/env bash

set -euo pipefail

pkill -TERM -o -x chromium || true
while pgrep -x --quiet chromium; do
  sleep 0.25
done

sleep 2

swaymsg "[all] kill" || true
while [ "$(swaymsg -t get_tree --raw | jq "[.. | objects | select(.pid? != null)] | length")" != "0" ]; do
  sleep 0.5
done

sleep 4

shutdown now

#!/usr/bin/env bash

PRIMARY_SCREEN="eDP-1"
EXTERNAL_SCREENS="$(swaymsg -r -t get_outputs | jq -r ".[] | .name" | grep -v "$PRIMARY_SCREEN")"

echo "PRIMARY: $PRIMARY_SCREEN"
echo "EXTERNAL: $EXTERNAL_SCREENS"

if pgrep -x "wl-mirror"; then
  pkill "wl-mirror"
else
  for external_screen in $EXTERNAL_SCREENS; do
    wl-mirror --fullscreen-output "$external_screen" "$PRIMARY_SCREEN" &
  done

  swaymsg focus output "$PRIMARY_SCREEN"
fi

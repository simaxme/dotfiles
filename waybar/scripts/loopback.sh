#!/bin/sh

PGREP_RESPONSE=$(pgrep -x pw-loopback)

if [ -n "$PGREP_RESPONSE" ]; then
  echo '{"text": "󱡬 '"$(echo "$PGREP_RESPONSE" | wc -l)"'", "class": "loopback-active"}'
else
  echo '{"text": "󱡬", "class": "loopback-inactive"}'
fi

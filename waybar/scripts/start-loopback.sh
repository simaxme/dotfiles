#!/bin/sh

if pgrep -x --quiet pw-loopback; then
  killall pw-loopback
else
  setsid pw-loopback &> /dev/null < /dev/null &
fi

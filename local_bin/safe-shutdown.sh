#!/usr/bin/env bash

set -euo pipefail

pkill -TERM -o -x chromium
while pgrep -x --quiet chromium; do
  sleep 0.5
done

shutdown now

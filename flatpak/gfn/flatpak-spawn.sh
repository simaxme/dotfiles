#!/usr/bin/env bash

set -euo pipefail

if [ "$1" != "--host" ] || [ "$2" != "xdg-open" ]; then
  echo "flatpak-spawn wrapper: not supported ($@)" >&2
  exit 1
fi

shift 2
xdg-open "$@"

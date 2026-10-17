#!/usr/bin/env bash

set -euo pipefail

RCLONE_STATUS="$(systemctl --user show -P ActiveState rclone-bisync)"

RESULT_ICON=" "

if [ "$RCLONE_STATUS" = "active" ] || [ "$RCLONE_STATUS" = "activating" ]; then
  RESULT_CLASS="syncing"
  RESULT_ICON="󰘿"
elif [ "$RCLONE_STATUS" = "failed" ] || [ "$RCLONE_STATUS" = "maintenance" ] || [ "$RCLONE_STATUS" = "reloading" ] || [ "$RCLONE_STATUS" = "refreshing" ]; then
  RESULT_CLASS="failed"
else
  RESULT_CLASS="success"
fi

echo "{\"text\": \"$RESULT_ICON\", \"alt\": \"Cloud Sync\", \"tooltip\": \"$RCLONE_STATUS\", \"class\": \"$RESULT_CLASS\"}"

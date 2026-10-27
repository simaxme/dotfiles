#!/usr/bin/env bash

set -euo pipefail

pkill -x -RTMIN+9 waybar || true # Update waybar module

RCLONE_REMOTES=$'%%REMOTES%%'
RCLONE_SYNC_FOLDER="$HOME/Documents/Cloud"

printf '%s' "$RCLONE_REMOTES" | while read -r line; do
  notify-send "Rclone bisync" "Started syncing '$line'"

  path="${line#*:}"

  mkdir -p "$HOME/.local/state/rclone"

  START_TIME=$SECONDS

  BACKUP_DIR_REMOTE="${line}-bak"
  BACKUP_DIR_LOCAL="$RCLONE_SYNC_FOLDER/${path}-bak"

  mkdir -p "$BACKUP_DIR_LOCAL"
  rclone mkdir "$BACKUP_DIR_REMOTE"

  rclone bisync "$line" "$RCLONE_SYNC_FOLDER/$path" \
    --create-empty-src-dirs \
    --resilient \
    --recover \
    --max-lock 2m \
    --conflict-resolve newer \
    --conflict-loser num \
    --backup-dir1 "$BACKUP_DIR_REMOTE" \
    --backup-dir2 "$BACKUP_DIR_LOCAL" \
    --stats 15s \
    --verbose \
    2>&1 | tee "$HOME/.local/state/rclone/bisync-$(date +"%Y_%m_%d-%H_%M").log"

  DURATION=$(( SECONDS - START_TIME ))

  notify-send "Rclone bisync" "Finished syncing '$line' (took ${DURATION}s)"
done

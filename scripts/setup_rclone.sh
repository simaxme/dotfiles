#!/usr/bin/env bash

set -euo pipefail

cd "$(dirname "$0")/.."

RCLONE_REMOTES_FILE="$(pwd)/rclone/remotes.txt"
RCLONE_BISYNC_SCRIPT="$(pwd)/rclone/rclone-bisync.sh"
RCLONE_BISYNC_SERVICE="$(pwd)/rclone/rclone-bisync.service"
RCLONE_BISYNC_WAYBAR_SERVICE="$(pwd)/rclone/waybar-rclone-bisync-refresh.service"
RCLONE_BISYNC_TIMER="$(pwd)/rclone/rclone-bisync.timer"
RCLONE_REMOTES="$(rclone listremotes)"

if [ -f "$RCLONE_REMOTES_FILE" ]; then
  FOUND_REMOTE=false
  RCLONE_RESULT_REMOTES=""

  while read -r line; do
    remote="${line%%:*}"
    path="${line#*:}"

    printf "%s" "Checking remote '$remote' path '$path'... "


    if [ -n "$line" ]; then
      if [[ "$line" != *":"* ]]; then
        printf "%s\n" "ERROR (Could not properly read line, due to missing : separator)"
        exit 1
      fi

      if ! echo "$RCLONE_REMOTES" | grep -q "^${remote}:$"; then
        printf "%s\n" "REMOTE NOT FOUND"
        exit 1
      fi


      if ! RCLONE_FOLDER_INFORMATION="$(rclone lsjson --stat "$line" 2> /dev/null)"; then
        printf "%s\n" "FOLDER NOT FOUND ON REMOTE"
        exit 1
      fi

      RCLONE_FOLDER_INFORMATION_IS_DIR="$(echo "$RCLONE_FOLDER_INFORMATION" | jq ".IsDir")"

      if [ "$RCLONE_FOLDER_INFORMATION_IS_DIR" != "true" ]; then
        printf "%s\n" "PATH ON REMOTE IS NOT A FOLDER";
        exit 1
      fi

      printf "%s\n" "VALID"
      RCLONE_RESULT_REMOTES="${RCLONE_RESULT_REMOTES}${line}"'\\n' # Required for sed to properly pass through \n as text
      FOUND_REMOTE=true
    else
      printf "%s\n" "SKIPPED"
    fi
  done < "$RCLONE_REMOTES_FILE"

  if [ "$FOUND_REMOTE" == "false" ]; then
    echo "Could not find one valid remote"
    exit 1
  fi

  mkdir -p "$HOME/.local/bin"
  RCLONE_SCRIPT_DIST="$HOME/.local/bin/rclone-bisync"

  cat "$RCLONE_BISYNC_SCRIPT" | sed "s/%%REMOTES%%/$RCLONE_RESULT_REMOTES/g" | tee "$RCLONE_SCRIPT_DIST"
  chmod +x "$RCLONE_SCRIPT_DIST"

  mkdir -p "$HOME/.config/systemd/user"
  cp "$RCLONE_BISYNC_SERVICE" "$HOME/.config/systemd/user"
  cp "$RCLONE_BISYNC_TIMER" "$HOME/.config/systemd/user"
  cp "$RCLONE_BISYNC_WAYBAR_SERVICE" "$HOME/.config/systemd/user"

  systemctl --user daemon-reload
else
  echo "No rclone remotes file found. Creating one. Please fill it out."

  if [ ! -e "$RCLONE_REMOTES_FILE" ]; then
    touch "$RCLONE_REMOTES_FILE"
  fi
fi

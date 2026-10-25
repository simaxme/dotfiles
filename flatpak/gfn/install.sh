#!/usr/bin/env bash

set -euo pipefail

flatpak override --user --reset com.nvidia.geforcenow

sudo flatpak remote-add --if-not-exists GeForceNOW https://international.download.nvidia.com/GFNLinux/flatpak/geforcenow.flatpakrepo

sudo flatpak override --nofilesystem=home --nofilesystem=host-etc com.nvidia.geforcenow
sudo flatpak override --nosocket=session-bus --nosocket=system-bus com.nvidia.geforcenow
sudo flatpak override --no-talk-name=org.freedesktop.Flatpak --no-talk-name=org.freedesktop.secrets com.nvidia.geforcenow

sudo flatpak install GeForceNOW com.nvidia.geforcenow

# Add a small wrapper script for "flatpak-spawn" to disallow executing any command on host
# This wrapper script only allows running xdg-open with --host and redirects this to the local xdg-open executable
GFN_BINARY_FOLDER="$HOME/.var/app/com.nvidia.geforcenow/data/bin"
mkdir -p "$GFN_BINARY_FOLDER"
cp "$(dirname "$0")/flatpak-spawn.sh" "$GFN_BINARY_FOLDER/flatpak-spawn"

GFN_PATH="$(flatpak run --command=sh com.nvidia.geforcenow -c 'echo $PATH')"
UPDATED_GFN_PATH="$GFN_BINARY_FOLDER/:$GFN_PATH"

flatpak override --user "--env=PATH=$UPDATED_GFN_PATH" com.nvidia.geforcenow


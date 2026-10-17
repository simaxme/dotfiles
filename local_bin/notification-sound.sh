#!/usr/bin/env bash

set -euo pipefail

# We do one second of silence
head -c $(( 1 * 2 * 48000 )) /dev/zero | pw-cat --playback --raw --latency 1024 --rate 48000 --channels 2 --format s16 -

# ... and then play the sound effect
pw-cat --playback --latency 1024 /usr/share/sounds/freedesktop/stereo/message.oga

#!/bin/bash
# Weston startup file.
export XDG_RUNTIME_DIR="/run/shm/wayland"
mkdir -p "$XDG_RUNTIME_DIR"
chmod 0700 "$XDG_RUNTIME_DIR"

# NOTE: locale settings is missing for weston
/usr/bin/weston --tty=1

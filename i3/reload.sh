#!/usr/bin/env bash

SCRIPTPATH="$HOME/.config/i3"

run_once() {
    if ! pgrep -x "$1" > /dev/null; then
        "$@" &
    fi
}

feh --bg-fill ${SCRIPTPATH}/wallpaper.jpg

# run_once autotiling-rs
run_once picom --config $SCRIPTPATH/external/picom.conf

# Launch Polybar, using default config location ~/.config/polybar/config
while pgrep -u $UID -x polybar >/dev/null; do sleep 1; done

for m in $(polybar --list-monitors | cut -d":" -f1); do
    MONITOR=$m polybar -c ${SCRIPTPATH}/external/config.ini --reload main &
done

#!/usr/bin/env bash

export SCRIPTPATH="$HOME/.config/i3"

run_once() {
    if ! pgrep -x "$1" > /dev/null; then
        "$@" &
    fi
}

feh --bg-fill ~/.config/i3/wallpaper.jpg
run_once autotiling &
run_once picom --config ${SCRIPTPATH}/external/picom.conf &> /dev/null &


killall -q polybar
while pgrep -u $UID -x polybar >/dev/null; do sleep 1; done

# Launch Polybar, using default config location ~/.config/polybar/config
for m in $(polybar --list-monitors | cut -d":" -f1); do
    MONITOR=$m polybar -c ${SCRIPTPATH}/external/config.ini --reload main &
done

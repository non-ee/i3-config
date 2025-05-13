#!/bin/bash

run_once() {
    if ! pgrep -x "$1" > /dev/null; then
        "$@" &
    fi
}

feh --bg-fill ~/.config/i3/wallpaper.png

nm-applet
autorandr --change
run_once fcitx5
run_once picom

~/.config/polybar/launch.sh &



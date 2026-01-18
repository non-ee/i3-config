#!/usr/bin/env bash

export PYTHONWARNINGS=ignore

current=$(autorandr --current 2>/dev/null)
profiles=$(autorandr --list)

[ -z "$profiles" ] && exit 0

chosen=$(echo "$profiles" | rofi -dmenu -p "Autorandr (${current:-none})")

[ -z "$chosen" ] && exit 0

autorandr --load "$chosen"


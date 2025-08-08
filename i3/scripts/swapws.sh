#!/usr/bin/env bash
# requires jq

# Save current mouse position
eval "$(xdotool getmouselocation --shell)"
OLD_X=$X
OLD_Y=$Y
OLD_SCREEN=$SCREEN

DISPLAY_CONFIG=($(i3-msg -t get_outputs | jq -r '.[]|"\(.name):\(.current_workspace)"'))

for ROW in "${DISPLAY_CONFIG[@]}"
do
IFS=':' read -ra CONFIG <<< "${ROW}"
OUTPUT="${CONFIG[0]}"
WORKSPACE="${CONFIG[1]}"
if [ "${CONFIG[0]}" != "null" ] && [ "${CONFIG[1]}" != "null" ]; then
    echo "moving ${WORKSPACE} right..."
    i3-msg -- workspace --no-auto-back-and-forth "${WORKSPACE}"
    i3-msg -- move workspace to output right	
fi
done


# Restore mouse position
xdotool mousemove --screen $OLD_SCREEN $OLD_X $OLD_Y

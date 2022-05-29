#!/bin/sh

player_status=$(playerctl status 2> /dev/null)

if [ "$player_status" = "Playing" ]; then
    bar=" $(playerctl metadata artist) - $(playerctl metadata title)"
elif [ "$player_status" = "Paused" ]; then
    bar=" $(playerctl metadata artist) - $(playerctl metadata title)"
else
    bar=""
fi

echo "| $bar"

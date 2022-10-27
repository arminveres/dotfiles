#!/bin/bash -e

# xrandr --output eDP-1 --mode 1920x1200 --output DP-3 --same-as eDP-1

xrandr --output eDP-1 --rate 60 --mode 1920x1200 --fb 1920x1200 --panning 1920x1200* --output DP-3 --mode 1920x1200 --same-as eDP-1


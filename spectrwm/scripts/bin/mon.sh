#!/bin/sh
xrandr --output eDP-1 --off --output HDMI-1 --off --output DP-1 --off --output HDMI-2 --off --output DP-2 --off --output HDMI-3 --off --output DP-1-1 --off --output DP-1-2 --off --output DP-1-3 --primary --mode 2560x1440 --pos 0x0 --rotate normal
feh --bg-fill ~/.config/wall-face.png

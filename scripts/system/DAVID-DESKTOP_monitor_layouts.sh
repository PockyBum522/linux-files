#!/bin/sh

# Run this, then open the cinnamon display settings, then flip something like the top right monitor to normal landscape, hit apply, then flip it back and hit apply and it should permanently save correctly

xrandr --output HDMI-0 --mode 3840x2160 --pos 0x1080 --rotate normal --output DP-0 --mode 3840x2160 --pos 7680x1080 --rotate normal --output DP-1 --off --output HDMI-1 --mode 1920x1080 --pos 4747x0 --rotate inverted --output DP-2 --primary --mode 3840x2160 --pos 3840x1080 --rotate normal --output DP-3 --off --output HDMI-1-1 --mode 1920x1080 --pos 2827x0 --rotate inverted --output DP-1-1 --mode 1920x1080 --pos 6667x0 --rotate inverted --output HDMI-1-2 --off

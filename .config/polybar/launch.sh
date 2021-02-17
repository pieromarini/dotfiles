#!/bin/bash

killall -q polybar
while pgrep -x polybar >/dev/null; do sleep 1; done

polybar main &

# NOTE: Launch secondary polybar if HDMI is connected
hdmi_monitor=$(xrandr -q | grep 'HDMI-1')
if [[ $hdmi_monitor != *disconnected* ]]; then
    polybar external &
fi

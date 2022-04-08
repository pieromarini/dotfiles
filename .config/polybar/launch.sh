#!/bin/bash

killall -q polybar
while pgrep -x polybar >/dev/null; do sleep 1; done

polybar -r main &

# NOTE: Launch secondary polybar if HDMI is connected
hdmi_monitor=$(xrandr -q | grep 'HDMI-0')
if [[ $hdmi_monitor != *disconnected* ]]; then
    polybar external &
fi

#!/usr/bin/env sh

# Terminate already running bar instances
killall -q polybar
while pgrep -x polybar >/dev/null; do sleep 1; done

polybar white &

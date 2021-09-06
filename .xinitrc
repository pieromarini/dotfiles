#!/bin/sh

xset -b # disable bell

if [ -d /etc/X11/xinit/xinitrc.d ] ; then
 for f in /etc/X11/xinit/xinitrc.d/?*.sh ; do
  [ -x "$f" ] && . "$f"
 done
 unset f
fi

[[ -f ~/.Xresources ]] && xrdb -merge -I$HOME ~/.Xresources

setxkbmap -layout us

xrandr --output HDMI-0 --mode 3440x1440 --rate 99.99

exec bspwm

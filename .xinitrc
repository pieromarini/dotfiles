#!/bin/sh

xset -b # disable bell

if [ -d /etc/X11/xinit/xinitrc.d ] ; then
 for f in /etc/X11/xinit/xinitrc.d/?*.sh ; do
  [ -x "$f" ] && . "$f"
 done
 unset f
fi

[[ -f ~/.Xresources ]] && xrdb -merge -I$HOME ~/.Xresources

setxkbmap -layout latam -option caps:swapescape

xrandr --auto

exec bspwm

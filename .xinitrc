#!/bin/sh

xset +fp /usr/share/fonts/local
xset fp rehash

xset -b # disable bell

if [ -d /etc/X11/xinit/xinitrc.d ] ; then
 for f in /etc/X11/xinit/xinitrc.d/?*.sh ; do
  [ -x "$f" ] && . "$f"
 done
 unset f
fi

[[ -f ~/.Xresources ]] && xrdb -merge -I $HOME ~/.xrdb/colors

setxkbmap -layout latam -option caps:swapescape

xrandr --auto

# Autostart
killall -q picom
while pgrep -x picom >/dev/null; do sleep 1; done
picom -b --config ~/.config/picom/picom.conf

killall -q dunst
killall -q notify-osd
while pgrep -x dunst >/dev/null; do sleep 1; done
while pgrep -x notify-osd >/dev/null; do sleep 1; done
dunst -config ~/.config/dunst/dunst &

killall -q sxhkd
while pgrep -x sxhkd >/dev/null; do sleep 1; done
sxhkd &

exec bspwm

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

[[ -f ~/.Xresources ]] && xrdb -merge -I $HOME ~/.Xresources

xmodmap ~/.Xmodmap
setxkbmap -layout latam -option caps:swapescape

xrandr --setprovideroutputsource modesetting NVIDIA-0
xrandr --auto

exec ~/Development/projects/dwm/dwm

# exec i3

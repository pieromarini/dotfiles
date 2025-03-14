#!/bin/bash

ROFI_OPTIONS=(-theme $HOME/.config/rofi/system)

select=$(echo "Lock
Suspend
Reboot
Poweroff" | awk '{print $(NF-1)}' | rofi "${ROFI_OPTIONS[@]}" -dmenu -i -p "System: ")

if [ "$select" == "Lock" ] ; then
	exec betterlockscreen --lock

elif [ "$select" == "Suspend" ] ; then
	systemctl suspend
		
elif [ "$select" == "Reboot" ] ; then
	reboot
	
elif [ "$select" == "Poweroff" ] ; then
	poweroff

else
    echo $select
fi

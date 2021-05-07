#!/bin/bash

ROFI_OPTIONS=(-theme $HOME/.config/rofi/system)

select=$(echo "Lock
Suspend
Reboot
Poweroff" | awk '{print $(NF-1)}' | rofi "${ROFI_OPTIONS[@]}" -dmenu -i -p "System: ")

if [ "$select" == "Lock" ] ; then
	exec betterlockscreen --lock

elif [ "$select" == "Suspend" ] ; then
	prompt "systemctl suspend" Suspend
		
elif [ "$select" == "Reboot" ] ; then
	prompt "reboot" Reboot
	
elif [ "$select" == "Poweroff" ] ; then
	prompt "poweroff" Poweroff	

else
    echo $select
fi

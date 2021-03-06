#!/bin/bash
ROFI_OPTIONS=(-theme $HOME/.config/rofi/config-browser)

select=$(echo "Configs
Shell
Scripts
Bin
Functions" | awk '{print $(NF-1)}' | rofi "${ROFI_OPTIONS[@]}" -dmenu -i -p "Config: ")


navigate(){
	selected=$(ls "$1/" | rofi "${ROFI_OPTIONS[@]}" -dmenu -p "$1: ")
	[[ -z $selected ]] && exit
	if [[ -f $1/$selected ]]; then
		# alacritty -e vim $1/$selected
		tmux-sendkeys config "vim $1/$selected"
	elif [[ -d $1/$selected ]]; then
		navigate $1/$selected
	else
		touch $1/$selected
		# alacritty -e vim $1/$selected
		tmux-sendkeys config "vim $1/$selected"
	fi
}


if [ "$select" == "Shell" ] ; then
	selected=$(echo "$HOME/.vimrc
$HOME/.zshrc
$HOME/.tmux.conf" | rofi "${ROFI_OPTIONS[@]}" -dmenu -p "shell: ")
		[[ -z $selected ]] && exit
	# alacritty -e vim $selected
	tmux-sendkeys config "vim $selected"

elif [ "$select" == "Configs" ] ; then
	navigate $HOME/.config;

elif [ "$select" == "Scripts" ] ; then
	navigate $HOME/.scripts;

elif [ "$select" == "Bin" ] ; then
	navigate $HOME/.bin;

elif [ "$select" == "Functions" ] ; then
	navigate $HOME/.func;

else
    echo $select
fi

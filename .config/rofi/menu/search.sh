#!/bin/bash

ROFI_OPTIONS_FULL=(-theme $HOME/.config/rofi/file-browser)

FILES=$(find ~/Documents ~/Downloads -type f -not -path "*/\.*"  -not -path "*/node_modules/*")
echo "${FILES}" | rofi "${ROFI_OPTIONS_FULL[@]}" -theme-str 'configuration{show-icons: false;}' -threads 1 -dmenu -i -p 'search: ' | xargs -r -0 xdg-open;

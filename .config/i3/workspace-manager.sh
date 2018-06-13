#!/bin/bash

workspace="$1"

# Currently focused workspace.
focused_workspace=$(i3-msg -t get_workspaces | jq --raw-output '.[]|select(.focused).name')

# We get prefix of current workspace so we know how to move.
prefix=$(echo $focused_workspace | awk '{print substr($0, 0, 1);}')

target_workspace=${prefix}${workspace}

i3-msg "workspace $target_workspace"

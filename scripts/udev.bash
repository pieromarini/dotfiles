#!/bin/bash

function unity-dev {
    BASE="$HOME/Development/Unity3D/TheOriginOfEvil/Assets/Scripts/"

    PLAYER="$HOME/Development/Unity3D/TheOriginOfEvil/Assets/Scripts/Player/"
    INVENTORY="$HOME/Development/Unity3D/TheOriginOfEvil/Assets/Scripts/Inventory/"
    ITEMS="$HOME/Development/Unity3D/TheOriginOfEvil/Assets/Scripts/Item/"
    STATS="$HOME/Development/Unity3D/TheOriginOfEvil/Assets/Scripts/Stats/"
    EQUIPMENT="$HOME/Development/Unity3D/TheOriginOfEvil/Assets/Scripts/Equipment/"

    tmux start-server
    cd $BASE
    tmux new-session -d -s Unity -n Main
    cd $INVENTORY
    tmux new-window -t Unity:2 -n Inventory
    cd $ITEMS
    tmux new-window -t Unity:3 -n Items
    cd $STATS
    tmux new-window -t Unity:4 -n Stats
    cd $EQUIPMENT
    tmux new-window -t Unity:5 -n Equipment

    tmux select-window -t Unity:1
    tmux attach-session -t Unity
}

unity-dev

#!/bin/bash

function mauripro-dev {

    Work="$HOME/Development/Work/"
    MPS="$HOME/Development/Work/MauriProSailing/"
    Sails="$HOME/Development/Work/Sails/"
    GSG="$HOME/Development/Work/GillSailingGear/"
    Layline="$HOME/Development/Work/Layline/"
    HenriLloyd="$HOME/Development/Work/HenriLloyd/"
    Utils="$HOME/Development/Work/utils/"

    cd $Work
    tmux start-server
    cd $MPS
    tmux new-session -d -s Work -n Mps
    cd $Sails
    tmux new-window -t Work:2 -n Sails
    cd $GSG
    tmux new-window -t Work:3 -n Gsg
    cd $Layline
    tmux new-window -t Work:4 -n Layline
    cd $HenriLloyd
    tmux new-window -t Work:5 -n HenriLloyd
    cd $Work
    tmux new-window -t Work:6 -n Ftp
    cd $Utils
    tmux new-window -t Work:7 -n Utilities

    tmux select-window -t Work:1
    tmux attach-session -t Work

#    tmux send-keys -t Work:1 "cd $MPS; clear;" C-m
#    tmux send-keys -t Work:2 "cd $Sails; clear;" C-m
#    tmux send-keys -t Work:3 "cd $GSG; clear;" C-m
#    tmux send-keys -t Work:4 "cd $Layline; clear;" C-m
#    tmux send-keys -t Work:5 "cd $HenriLloyd; clear;" C-m
#    tmux send-keys -t Work:6 "cd $Work; clear;" C-m
#    tmux send-keys -t Work:7 "cd $Utils; clear;" C-m

}

mauripro-dev

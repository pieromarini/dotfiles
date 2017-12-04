#!/bin/bash

function mauripro-dev {

    Work="$HOME/Development/Work/"
    MPS="$HOME/Development/Work/MauriProSailing/"
    Zalek="$HOME/Development/Work/ZalekShop/"
    Bogaz="$HOME/Development/Work/BogazGourmet/"
    Layline="$HOME/Development/Work/Layline/"
    HenriLloyd="$HOME/Development/Work/HenriLloyd/"

    cd $MPS
    tmux start-server
    tmux new-session -d -s Work -n Mps
    cd $Zalek
    tmux new-window -t Work:2 -n Zalek
    cd $Bogaz
    tmux new-window -t Work:3 -n Bogaz
    cd $Layline
    tmux new-window -t Work:4 -n Layline
    cd $HenriLloyd
    tmux new-window -t Work:5 -n HenriLloyd
    cd $Work
    tmux new-window -t Work:6 -n Ftp
    tmux new-window -t Work:7 -n Utilities


    tmux select-window -t Work:1
    tmux attach-session -t Work
#    tmux send-keys -t Work:1 "cd $MPS; clear;" C-m
#    tmux send-keys -t Work:2 "cd $Zalek; clear;" C-m
#    tmux send-keys -t Work:3 "cd $Bogaz; clear;" C-m
#    tmux send-keys -t Work:4 "cd $Layline; clear;" C-m
#    tmux send-keys -t Work:5 "cd $HenriLloyd; clear;" C-m
#    tmux send-keys -t Work:6 "cd $Work; clear;" C-m
#    tmux send-keys -t Work:7 "cd $Work; clear;" C-m

}

mauripro-dev

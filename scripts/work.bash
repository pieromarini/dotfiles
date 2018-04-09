#!/bin/bash

function mauripro-dev {
    Work="$HOME/Development/Work/"
    Utils="$HOME/Development/Work/utils/"

    cd $Work
    tmux start-server
    tmux new-session -d -s Work -n Main
    cd $Utils
    tmux new-window -t Work:2 -n Utilities

    tmux select-window -t Work:1
    tmux attach-session -t Work
}

mauripro-dev

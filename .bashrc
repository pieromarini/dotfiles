#   File: .bashrc
#   Last Edit: 17 Jul 2018
#   Author: Piero Marini

export PATH=~/.scripts:~/.bin:$PATH

source /etc/profile

export LANG=en_US.UTF-8

export VIMRC=~/.vimrc
export BASHRC=~/.bashrc

export EDITOR=vim
export VISUAL=vim
export TERMINAL="alacritty -e"


# Python VirtualEnv
export WORKON_HOME=$HOME/.virtualenvs
export PROJECT_HOME=$HOME/Development/Python
source /usr/bin/virtualenvwrapper.sh

#############################
########## Aliases ##########
#############################

# Directory Aliases
alias mkdir='mkdir -p' # Always create necessary directories.
alias ..='cd ..' # Back a directory.
alias ...='cd ../..'
alias ....='cd ../../..'
alias .....='cd ../../../..'
# End Directory Aliases

# ls Aliases
alias ls='ls -h --color=auto' # Colored output, human readable.
alias lx='ls -lXB' # Sort by extension.
alias lk='ls -lS' # Sort by size.
alias lt='ls -lt' # Sort by date.

alias ll='ls -lvF --group-directories-first' # Directories first, alphanumeric sorting.
alias lm='ll |more' # Pipe to more.
alias lr='ll -R' # Recursive ls.
alias la='ll -A' # Show hidden files.

alias lh='ls --ignore="*.meta"' # Special ls to hide meta files from Unity3D.

# End ls Aliases

alias open='xdg-open'

# Quick Navigation
alias utec='cd ~/Documents/Utec/2018-1/'
alias toe='cd ~/Development/Unity3D/TheOriginOfEvil/Assets/Scripts/'

# Use dircolors to set $LC_COLORS
if [ -f /usr/bin/dircolors ]; then
    [ -e "$HOME/.dir_colors" ] && DIR_COLORS="$HOME/.dir_colors"
    [ -e "$DIR_COLORS" ] || DIR_COLORS=""
    eval "$(dircolors -b $DIR_COLORS)"
fi


###############################
######### Functions ###########
###############################

# Bulk Helpers
function remove-prefix(){
    if [ $# -ne 2 ] 
    then 
        echo "Usage: remove-prefix [files_expr] [prefix_to_delete]"
        echo "Ex: remove-prefix '*.extension' 'prefix'"
        return 1
    fi

    for f in $1; do
        mv "$f" "${f#$2}";
    done
}

function add-prefix(){
    if [ $# -ne 2 ] 
    then 
        echo "Usage: add-prefix [files_expr] [prefix_to_add]"
        echo "Ex: add-prefix '*.extension' 'prefix'"
        echo "Returns: prefix*.extension"
        return 1
    fi

    for f in $1; do
        mv "$f" "$2$f";
    done
}

function add-suffix(){
    if [ $# -ne 2 ] 
    then 
        echo "Usage: add-suffix [files_expr] [suffix_to_add]"
        echo "Ex: add-suffix '*.extension' 'suffix'"
        echo "Returns: *suffix.extension"
        return 1
    fi

    for f in $1; do 
        mv "$f" "${f%.*}$2.${f##*.}"
    done
}

function remove-suffix(){
    if [ $# -ne 2 ] 
    then 
        echo "Usage: remove-suffix [files_expr] [suffix_to_remove]"
        echo "Ex: remove-suffix '*suffix.extension' 'suffix'"
        echo "Returns: *.extension"
        return 1
    fi

    for f in $1; do 
        mv "$f" "${f/$2/}";
    done
}
# End Bulk Helpers

# Swap two filenames.
function swap(){
    local TMPFILE=tmp.$$

    [ $# -ne 2 ] && echo "swap: 2 arguments needed" && return 1
    [ ! -e $1 ] && echo "swap: $1 does not exist" && return 1
    [ ! -e $2 ] && echo "swap: $2 does not exist" && return 1

    mv "$1" $TMPFILE
    mv "$2" "$1"
    mv $TMPFILE "$2"
}

# Update Pacman Mirror with Reflector
function reflectorupdate(){
    sudo reflector --verbose --latest 100 --sort rate --save /etc/pacman.d/mirrorlist
}

# Extract Recognition
function extract(){
    if [ -f $1 ] ; then
        case $1 in
            *.tar.bz2)   tar xvjf $1     ;;
            *.tar.gz)    tar xvzf $1     ;;
            *.bz2)       bunzip2 $1      ;;
            *.rar)       unrar x $1      ;;
            *.gz)        gunzip $1       ;;
            *.tar)       tar xvf $1      ;;
            *.tbz2)      tar xvjf $1     ;;
            *.tgz)       tar xvzf $1     ;;
            *.zip)       unzip $1        ;;
            *.Z)         uncompress $1   ;;
            *.7z)        7z x $1         ;;
            *)           echo "'$1' cannot be extracted via >extract<" ;;
        esac
    else
        echo "'$1' is not a valid file!"
    fi
}

# Determine size of a file or total size of a directory
function fs() {
    if du -b /dev/null > /dev/null 2>&1; then
        local arg=-sbh;
    else
        local arg=-sh;
    fi
    if [[ -n "$@" ]]; then
        du $arg -- "$@";
    else
        du $arg .[^.]* ./*;
    fi;
}

# Get current host related info.
function ii(){
    echo -e "\nYou are logged on ${BRed}$HOST"
    echo -e "\n${BRed}Additionnal information:$NC " ; uname -a
    echo -e "\n${BRed}Users logged on:$NC " ; w -hs |
        cut -d " " -f1 | sort | uniq
    echo -e "\n${BRed}Current date :$NC " ; date
    echo -e "\n${BRed}Machine stats :$NC " ; uptime
    echo -e "\n${BRed}Memory stats :$NC " ; free
    echo
}

# Tmux Session shortcuts
function tmuxkill(){
    tmux kill-session -t $1
}
function tmuxnew(){
    tmux new-session -t $1
}
function tmuxattach(){
    tmux attach-session -t $1
}
# End Tmux Session shortcuts

# Apache Dev
function wordpress-devserver(){
    echo "Starting Apache & MySQL"
    sudo systemctl start mysqld httpd
    systemctl status mysqld httpd
}

# End Apache Dev

# Powerline-Shell Functions
function _update_ps1() {
    PS1=$(powerline-shell $?)
}

if [[ $TERM != linux && ! $PROMPT_COMMAND =~ _update_ps1 ]]; then
    PROMPT_COMMAND="_update_ps1; $PROMPT_COMMAND"
fi
# End Powerline-Shell Functions

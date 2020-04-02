#   File: .zshrc
#   Last Edit: 01 Apr 2020
#   Author: Piero Marini

typeset -U path
path=(~/.scripts ~/.bin ~/.npm-global/bin /usr/msc/bin $path[@])

xrdb ~/.Xresources

export WINIT_HIDPI_FACTOR=1.083
export DISABLE_UPDATE_PROMT=true

# Alias for dotfiles managing
alias config='/usr/bin/git --git-dir=$HOME/.cfg/ --work-tree=$HOME'

export BAT_CONFIG_PATH="${HOME}/.config/bat/config"

# Miva Merchant Mivascript Compiler
export MVCBIN="/usr/msc/bin/"
export MVC_LIB="/usr/msc/builtins/"

zstyle ':completion:*' menu select

export ZSH="/home/piero/.oh-my-zsh"

# FZF Configs

export FZF_DEFAULT_COMMAND="rg --no-messages --files --hidden --ignore-file ~/.ignore"
export FZF_DEFAULT_OPTS="
  --preview=\"(bat --style=numbers,changes --color=always {}) 2>/dev/null | head -200\" 
  --preview-window=right:60%:wrap 
  --color fg:-1,bg:-1,hl:33,fg+:254,bg+:235,hl+:33
  --color info:136,prompt:136,pointer:230,marker:230,spinner:136
"
export FZF_TMUX=1

# THEME CONFIG
export AM_THEME=soft
export USE_NERD_FONT=1
unset AM_INITIAL_LINE_FEED
export AM_SHOW_FULL_DIR=1
export PROMPT_END_TAG=' $'
export PROMPT_END_TAG_COLOR=83
export AM_HIDE_EXIT_CODE=1

ZSH_THEME="alien-minimal/alien-minimal"

bindkey -v
export KEYTIMEOUT=0.1

# Bulk renaming utility.
autoload -U zmv

# History Search. Past commands matching the current line.
autoload -Uz up-line-or-beginning-search down-line-or-beginning-search
zle -N up-line-or-beginning-search
zle -N down-line-or-beginning-search

[[ -n "$key[Up]"   ]] && bindkey -- "$key[Up]"   up-line-or-beginning-search
[[ -n "$key[Down]" ]] && bindkey -- "$key[Down]" down-line-or-beginning-search

plugins=(
  git
  vi-mode
  zsh-syntax-highlighting
)

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"

source $ZSH/oh-my-zsh.sh

export LANG=en_US.UTF-8

export SHELL=zsh
export EDITOR=vim
export VISUAL=vim

export V=~/.vimrc
export Z=~/.zshrc
export T=~/.tmux.conf
export TERMINAL="urxvt -e"

# Shortcuts
alias t=tmux
alias c=clear
alias f=fzf
alias v=vim
alias n=nnn
# I dont wanna type sxiv
alias img=sxiv
# Open file in vim through Fzf.
alias fv='vim $(fzf)'
alias mc='tmux split -h lf; lf'

# Python VirtualEnv
export WORKON_HOME=$HOME/.virtualenvs
export PROJECT_HOME=$HOME/Development/Python
export VIRTUALENVWRAPPER_PYTHON=/usr/bin/python3.8
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
alias ls=lsd
alias lt='ls -lt' # Sort by date.
alias lk='ls -lS' # Sort by size.

alias ll='ls -lF --group-dirs first' # Directories first.
alias la='ll -a' # Show hidden files.
# End ls Aliases

alias open='xdg-open'

# Use dircolors to set $LC_COLORS
if [ -f /usr/bin/dircolors ]; then
  [ -e "$HOME/.dir_colors" ] && DIR_COLORS="$HOME/.dir_colors"
  [ -e "$DIR_COLORS" ] || DIR_COLORS=""
  eval "$(dircolors -b $DIR_COLORS)"
fi

###############################
######### Functions ###########
###############################

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

# Fuzzy Directory search
function fd() {
  local dir
  dir=$(find ${1:-.} -path '*/\.*' -prune -o -type d -print 2> /dev/null | fzf --height=70% +m --reverse --preview="") && cd "$dir"
}

# Text to PDF
# TODO: add checks
function txt2pdf() {
  local arg=$1
  enscript -p tmp.ps $arg
  ps2pdf tmp.ps ${arg%.*}.pdf
  rm tmp.ps
}

function md2pdf() {
  local arg=$1
  pandoc $arg -V geometry:margin=0.5in --pdf-engine=xelatex -o ${arg%.*}.pdf
}

# Tmux Session shortcuts
function tkill(){
  tmux kill-session -t $1
}
function tnew(){
  tmux new-session -t $1
}
function tattach(){
  tmux attach-session -t $1
}
# End Tmux Session shortcuts

# Monitor Management
function monitor() {
  case $1 in
	"left")  xrandr --output HDMI-1 --auto --left-of eDP-1 ;;
	"right") xrandr --output HDMI-1 --auto --right-of eDP-1 ;;
	"reset") xrandr --auto ;;
	*) echo "Valid options are: left|right|reset"
  esac
}

#!/bin/zsh

setopt prompt_subst
autoload -U colors && colors

# _newline=$'\n'
GREEN="%{$fg_bold[green]%}"
GRAY="%{$fg_bold[gray]%}"
YELLOW="%{$fg_bold[yellow]%}"
CYAN="%{$fg_bold[cyan]%}"
MAGENTA="%{$fg_bold[magenta]%}"
RED="%{$fg_bold[red]%}"
RESET="%{$reset_color%}"

if [[ $UID == 0 || $EUID == 0 ]]; then
  _color=$RED
else
  _color=$GREEN
fi

# get the name of the branch we are on
git_prompt_info() {
  ref=$(git symbolic-ref HEAD 2> /dev/null) || return
  echo " $CYAN${ref#refs/heads/}$RESET "
}

set_hostname() {
  if [ -n "$SSH_CLIENT" ] || [ -n "$SSH_TTY" ]; then
    echo "$MAGENTA%m$RESET"
  fi
}

check_running_proc() {
  echo "$_color%(1j.◆.◊)$RESET "
}

PROMPT='$(set_hostname)$YELLOW%c$RESET $(git_prompt_info)$(check_running_proc)$RESET'

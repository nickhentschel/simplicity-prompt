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
  echo "%F{$_color}[%n%F{198}@%F{244}%m%F{$_color}]%{$reset_color%}"
}

check_running_proc() {
  echo "$RED%(1j.∙.)$RESET "
}

# PROMPT='%F{$_color}┌───$(set_hostname)$(git_prompt_info)$(check_running_proc)${_newline}%F{$_color}└ %{$reset_color%}'
PROMPT='$_color⬢  $YELLOW%c$RESET $(git_prompt_info)$(check_running_proc)'

#!/bin/zsh

setopt prompt_subst
autoload -U colors && colors

_newline=$'\n'

if [[ $UID == 0 || $EUID == 0 ]]; then
  _color="160"
else
  _color="236"
fi

# get the name of the branch we are on
git_prompt_info() {
  ref=$(git symbolic-ref HEAD 2> /dev/null) || return
  echo "%F{$_color}─[%F{244}$(basename `git rev-parse --show-toplevel`)::%{$fg[green]%}${ref#refs/heads/}%F{$_color}]%F{$_color}"
}

set_hostname() {
  echo "%F{$_color}[%n%F{198}@%F{244}%m%F{$_color}]%{$reset_color%}"
}

check_running_proc() {
  echo "%{$fg[yellow]%}%(1j.∙.)%{$reset_color%}"
}

PROMPT='%F{$_color}┌───$(set_hostname)$(git_prompt_info)$(check_running_proc)${_newline}%F{$_color}└ %{$reset_color%}'

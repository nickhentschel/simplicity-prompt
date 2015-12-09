#!/bin/zsh
autoload -U colors
colors
setopt prompt_subst

# get the name of the branch we are on
git_prompt_info() {
  ref=$(git symbolic-ref HEAD 2> /dev/null) || return
  echo " %{$fg[green]%}${ref#refs/heads/}%{$reset_color%}"
}

check_root() {
  symbol=""
  if [[ $UID == 0 || $EUID == 0 ]]; then
    symbol=" %{$fg[red]%}# "
  else
    symbol=" %{$reset_color%}$ "
  fi
  echo $symbol
}

check_ssh() {
  if [ -n "$SSH_CLIENT" ] || [ -n "$SSH_TTY" ]; then
    echo "%{$fg[magenta]%}%m%{$reset_color%} "
  fi
}

PROMPT='%{$fg[red]%}%(1j.*.)%{$fg[blue]%}[$(check_ssh)%{$fg[blue]%}%1~$(git_prompt_info)%{$fg[blue]%}]$(check_root)%{$reset_color%}'

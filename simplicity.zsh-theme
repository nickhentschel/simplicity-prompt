#!/bin/zsh
autoload -U colors
colors
setopt prompt_subst

RESET="%{$reset_color%}"
RED="%{$fg[red]%}"
BLUE="%{$fg[blue]%}"
GREEN="%{$fg[green]%}"
MAGENTA="%{$fg[magenta]%}"

# get the name of the branch we are on
git_prompt_info() {
  ref=$(git symbolic-ref HEAD 2> /dev/null) || return
  echo " ${GREEN}${ref#refs/heads/}${RESET}"
}

check_root() {
  echo "%(!.${RED} #.${RESET} $) "
}

check_osx() {
  if ! [[ "$(uname)" =~ "Darwin" ]]; then
    if [[ "$(hostname -f)" =~ "dev" ]]; then
      echo "${RESET}%3m${RESET} "
    else
      echo "${RED}%3m${RESET} "
    fi
  fi
}

get_path() {
  echo "${BLUE}%20<...<%~%<<${RESET}"
}

PROMPT='${RED}%(1j.* .)$(check_osx)$(get_path)$(git_prompt_info)$(check_root)${RESET}'

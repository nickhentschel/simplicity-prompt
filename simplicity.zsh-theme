#!/bin/zsh
setopt prompt_subst

# get the name of the branch we are on
git_prompt_info() {
  ref=$(git symbolic-ref HEAD 2> /dev/null) || return
  echo " %F{green}[%B${ref#refs/heads/}%b%f%F{green}]%f"
}

check_osx() {
  if [[ "$(hostname -f)" =~ "sec|host|stg" ]]; then
    echo "%F{red}%3m%f "
  else
    echo "%F{magenta}%B%3m%b%f "
  fi
}

PROMPT='%F{red}%B%(1j.* .)%f$(check_osx)%b%F{blue}[%B%~%b%f%F{blue}]%f$(git_prompt_info)%(!.%F{red} #%f. >) '

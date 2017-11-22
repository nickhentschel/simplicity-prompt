#!/bin/zsh
setopt prompt_subst

# get the name of the branch we are on
git_prompt_info() {
  ref=$(git symbolic-ref HEAD 2> /dev/null) || return
  echo " %F{green}[%B${ref#refs/heads/}%b]%f"
}

check_osx() {
  if [ -n "$SSH_CLIENT" ] || [ -n "$SSH_TTY" ]; then
    if [[ "$(hostname -f)" =~ "dev" ]]; then
      echo "%F{magenta}%3m%f "
    else
      echo "%F{red}%B%3m%b%f "
    fi
  fi
}

PROMPT='%F{red}%B%(1j.* .)%f$(check_osx)%b%F{blue}[%B%~%b]%f$(git_prompt_info)%(!.%F{red} #%f. ») '

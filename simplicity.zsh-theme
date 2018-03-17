#!/bin/zsh
setopt prompt_subst

# get the name of the branch we are on
git_prompt_info() {
  ref=$(git symbolic-ref HEAD 2> /dev/null) || return
  echo " %F{green}[%B${ref#refs/heads/}%b%f%F{green}]%f"
}

check_host() {
  if [[ "$(hostname -f)" =~ "sec|host|stg" ]]; then
    echo "%K{red}%B%n@%3m%b%k"
  elif [[ "$(hostname -f)" =~ "dev" ]]; then
    echo "%K{10}%B@%3m%b%k"
  else
    echo "%K{blue}%B%n@%3m%b%k"
  fi
}

# PROMPT='%F{red}%B%(1j.* .)%f$(check_host)%b%F{blue}[%B%~%b%f%F{blue}]%f$(git_prompt_info)%(!.%F{red} #%f. >) '
PROMPT='%F{red}%B%(1j.* .)%f$(check_host):%F{blue}%B%~%b%(!.%F{red}#%f.%f$) '
RPROMPT='$(git_prompt_info)'

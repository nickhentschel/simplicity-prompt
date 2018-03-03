#!/bin/zsh
setopt prompt_subst

# get the name of the branch we are on
git_prompt_info() {
  ref=$(git symbolic-ref HEAD 2> /dev/null) || return
  echo " %F{green}[%B${ref#refs/heads/}%b%f%F{green}]%f"
}

check_host() {
  if ! [[ "$(uname)" =~ "Darwin" ]]; then
    if [[ "$(hostname -f)" =~ "sec|host|stg" ]]; then
      echo "%F{red}%B@%3m%b%f"
    else
      echo "%F{green}%B@%3m%b%f"
    fi
  fi
}

# PROMPT='%F{red}%B%(1j.* .)%f$(check_host)%b%F{blue}[%B%~%b%f%F{blue}]%f$(git_prompt_info)%(!.%F{red} #%f. >) '
PROMPT='%F{red}%B%(1j.* .)%f%(!.%F{red}.%F{green})%B%n%f%b$(check_host):%F{blue}%B%~%b%(!.%F{red}#.%f$) '
RPROMPT='$(git_prompt_info)'

setopt prompt_subst

# get the name of the branch we are on
_git_prompt_info() {
  ref=$(git symbolic-ref HEAD 2> /dev/null) || return
  echo "%F{246}%B[%b%f${ref#refs/heads/}%F{246}%B]%b%f "
}

zle-keymap-select() {
  zle reset-prompt
  zle -R
}

_is_ssh() {
  [[ -n "${SSH_CONNECTION-}${SSH_CLIENT}${SSH_TTY}" ]]
}

_vi_mode_indicator() {
  case $KEYMAP in
    vicmd) print -n ':' ;;
    *) print -n '%#' ;;
  esac
}

simplicity_zsh_theme() {
  short_path='%(5~|%-1~/…/%3~|%4~)'

  zle -N zle-keymap-select

  if _is_ssh || [[ $EUID -eq 0 ]]; then
    host="@%3m"
  else
    host=''
  fi

  PROMPT='%(?..%B%F{red}(%?%)%f%b )%F{red}%B%(1j.* .)%f%n%F{246}%B$host%b %F{246}%B$short_path %b%f$(_git_prompt_info)$(_vi_mode_indicator) '
}

simplicity_zsh_theme

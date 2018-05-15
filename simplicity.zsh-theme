setopt prompt_subst

# get the name of the branch we are on
_git_prompt_info() {
  ref=$(git symbolic-ref HEAD 2> /dev/null) || return
  echo "%F{white}[${ref#refs/heads/}]%f "
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
  short_path='%F{245}%(5~|%-1~/…/%3~|%4~)%f'

  zle -N zle-keymap-select

  if _is_ssh || [[ $EUID -eq 0 ]]; then
    host="%F{cyan}@%3m%f"
  else
    host=''
  fi

  PROMPT='%(?..%F{red}(%?%)%f )%F{red}%(1j.* .)%f%n$host $short_path $(_git_prompt_info)$(_vi_mode_indicator) '
}

simplicity_zsh_theme

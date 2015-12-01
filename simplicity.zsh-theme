setopt prompt_subst
autoload -U colors && colors

_newline=$'\n'
if [[ $UID == 0 || $EUID == 0 ]]; then
    _color="red"
else
    _color="default"
fi

# get the name of the branch we are on
function git_prompt_info() {
    ref=$(git symbolic-ref HEAD 2> /dev/null) || return
    echo " %{$fg[$_color]%}[%{$fg[default]%}$(basename `git rev-parse --show-toplevel`)::%{$fg[green]%}${ref#refs/heads/}%{$fg[$_color]%}]%{$fg[$_color]%}"
}

function check_ssh() {
    if [ -n "$SSH_CLIENT" ] || [ -n "$SSH_TTY" ]; then
        echo "%{$fg[magenta]%}%n@%m%{$reset_color%} "
    fi
}

function check_running_proc() {
    echo "%{$fg[red]%}%(1j.∙.)%{$reset_color%}"
}

PROMPT='%{$fg[$_color]%}┌─── $(check_ssh)%~$(git_prompt_info) $(check_running_proc)${_newline}%{$fg_bold[$_color]%}└ '

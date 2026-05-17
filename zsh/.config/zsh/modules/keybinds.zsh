#!/usr/bin/env zsh
#
# Custom functions and their keybindings.

#
# Search files in $XDG_CONFIG_HOME
#
function __search_dot_config() {
    # capture files in variable
    local sel_conf=$(fd --max-depth 1 . "$XDG_CONFIG_HOME" | fzf)

    if [[ -n $sel_conf ]]; then
        nvim -c "lua Snacks.picker.files({ hidden = true, dirs = { '$sel_conf' } })"
    # else
    #     echo "INFO: Nothing selected!"
    fi
    zle redisplay
}
zle -N __search_dot_config
bindkey '^_' __search_dot_config

#
# Fuzzy find local files and open them in editor
#
function __fzf_editor_files() {
    local output=$(
        fd --type=file --hidden --exclude="*.png" --exclude="*.svc" --exclude="*.jpg" --exclude="*.jpeg" |
            fzf --preview 'bat --color=always {}'
    )

    if [[ -n $output ]]; then
        $EDITOR "$output"
    # else
    # 	printf "Nothing selected!\n"
    fi
    zle redisplay
}
zle -N __fzf_editor_files
bindkey '^v' __fzf_editor_files

#
# Interactively cd through zoxide.
#
# function __zoxide_interactive() {
#     cdi "$@"
#     # TODO(aver): fix reset prompt
#     echo
#     # zle reset-prompt
#     # zle redisplay
# }
# # Zoxide binding
# zle -N __zoxide_interactive
# bindkey '^f' __zoxide_interactive
bindkey -s '^f' '^Ucdi^M'

bindkey -s '^z' '^Uwtcd^M'

bindkey '^o' end-of-line

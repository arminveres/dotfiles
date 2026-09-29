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

# NOTE(aver): zsh-vi-mode re-initializes keymaps on the first precmd, which
# runs *after* this file is sourced, wiping out any plain top-level `bindkey`
# call. Everything below must go through `zvm_after_init_commands` (see
# https://github.com/jeffreytse/zsh-vi-mode#execute-extra-commands) so the
# bindings survive.
function _keybinds_zvm_setup() {
    bindkey '^_' __search_dot_config
    bindkey $'\e[47;5u' __search_dot_config

    bindkey '^v' __fzf_editor_files

    bindkey -s '^f' '^Ucdi^M'

    bindkey -s '^z' '^Uwtcd^M'

    bindkey '^o' end-of-line

    # Fix ctrl-w: kill back to previous whitespace only (vi-style)
    bindkey -M viins "^W" vi-backward-kill-word
}
zvm_after_init_commands+=(_keybinds_zvm_setup)

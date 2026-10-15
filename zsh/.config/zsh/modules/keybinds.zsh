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

# Run interactive commands from a widget: take over tty, then redraw prompt.
function __cdi_widget() {
    zle -I
    cdi </dev/tty
    zle reset-prompt
}
zle -N __cdi_widget

function __wtcd_widget() {
    zle -I
    wtcd </dev/tty
    zle reset-prompt
}
zle -N __wtcd_widget

# NOTE(aver): zsh-vi-mode re-initializes keymaps on the first precmd, which
# runs *after* this file is sourced, wiping out any plain top-level `bindkey`
# call. Everything below must go through `zvm_after_init_commands` (see
# https://github.com/jeffreytse/zsh-vi-mode#execute-extra-commands) so the
# bindings survive.
function _keybinds_zvm_setup() {
    bindkey '^_' __search_dot_config
    bindkey $'\e[47;5u' __search_dot_config

    bindkey '^v' __fzf_editor_files

    bindkey '^f' __cdi_widget
    bindkey '^z' __wtcd_widget

    bindkey '^o' end-of-line

    # Fix ctrl-w: kill back to previous whitespace only (vi-style)
    bindkey -M viins "^W" vi-backward-kill-word

    # search using a prefix, e.g., `cd` only searches history including cd
    autoload -U up-line-or-beginning-search
    zle -N up-line-or-beginning-search
    bindkey "^p" up-line-or-beginning-search

    autoload -U down-line-or-beginning-search
    zle -N down-line-or-beginning-search
    bindkey "^n" down-line-or-beginning-search

    # Edit line in vim with ctrl-e:
    autoload edit-command-line
    zle -N edit-command-line
    bindkey '^e' edit-command-line

    command -v fzf >/dev/null && source <(fzf --zsh)

    # Must run after fzf --zsh, which rebinds ^I to fzf-completion.
    bindkey '^I' expand-dots-then-expand-or-complete
    bindkey '^M' expand-dots-then-accept-line
}
zvm_after_init_commands+=(_keybinds_zvm_setup)

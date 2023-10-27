#!/bin/zsh

# Setup fzf
# ---------
if [[ ! -f "$ZDOTDIR"/plugins/fzf/bin/fzf ]]; then
    "$ZDOTDIR"/plugins/fzf/install --bin
fi

if [[ ! "$PATH" == */home/armin/pers_git/fzf/bin* ]]; then
    PATH="${PATH:+${PATH}:}$ZDOTDIR/plugins/fzf/bin"
fi

# Auto-completion
# ---------------
[[ $- == *i* ]] && source "$ZDOTDIR/scripts/fzf-completion.zsh" 2> /dev/null

# Key bindings
# ------------
# source "/home/armin/pers_git/fzf/shell/key-bindings.zsh"
source "$ZDOTDIR/scripts/fzf-keybindings.zsh"

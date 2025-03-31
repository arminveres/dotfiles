# Setup fzf
# ---------
if ! command -v fzf >/dev/null; then
    if [[ ! -f "$ZDOTDIR"/plugins/fzf/bin/fzf ]]; then
        "$ZDOTDIR"/plugins/fzf/install --bin
    fi
    if [[ ! "$path" == *fzf/bin* ]]; then
        path+="$ZDOTDIR/plugins/fzf/bin"
    fi
fi

# Auto-completion
# ---------------
[[ $- == *i* ]] && source "$ZDOTDIR/plugins/fzf/shell/completion.zsh" 2>/dev/null

# Key bindings
# ------------
source "$ZDOTDIR/plugins/fzf/shell/key-bindings.zsh"

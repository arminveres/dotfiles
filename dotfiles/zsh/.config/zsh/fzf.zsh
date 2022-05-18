# TODO: use default binary and import shell scripts into own configs
# Setup fzf
# ---------
if [[ ! "$PATH" == *$HOME/gitfiles/Dependencies/fzf/bin* ]]; then
  export PATH="${PATH:+${PATH}:}$HOME/gitfiles/Dependencies/fzf/bin"
fi

# Auto-completion
# ---------------
[[ $- == *i* ]] && source "$HOME/gitfiles/Dependencies/fzf/shell/completion.zsh" 2> /dev/null

# Key bindings
# ------------
source "$HOME/gitfiles/Dependencies/fzf/shell/key-bindings.zsh"

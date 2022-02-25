# Setup fzf
# ---------
if [[ ! "$PATH" == */home/avee/gitFiles/fzf/bin* ]]; then
  export PATH="${PATH:+${PATH}:}/home/avee/gitFiles/fzf/bin"
fi

# Auto-completion
# ---------------
[[ $- == *i* ]] && source "/home/avee/gitFiles/fzf/shell/completion.zsh" 2> /dev/null

# Key bindings
# ------------
source "/home/avee/gitFiles/fzf/shell/key-bindings.zsh"

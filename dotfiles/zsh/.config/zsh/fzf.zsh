# Setup fzf
# ---------
if [[ ! "$PATH" == */home/arminveres/gitfiles/fzf/bin* ]]; then
  export PATH="${PATH:+${PATH}:}/home/arminveres/gitfiles/Dependencies/fzf/bin"
fi

# Auto-completion
# ---------------
[[ $- == *i* ]] && source "/home/arminveres/gitfiles/Dependencies/fzf/shell/completion.zsh" 2> /dev/null

# Key bindings
# ------------
source "/home/arminveres/gitfiles/Dependencies/fzf/shell/key-bindings.zsh"

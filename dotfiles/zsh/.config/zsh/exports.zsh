# History
HISTFILE=~/.config/zsh/zsh_history
HISTSIZE=20000
SAVEHIST=20000
setopt appendhistory

export PATH=$HOME/bin:/usr/local/bin:$PATH
export JDTLS_HOME="/home/arminveres/.local/share/nvim/lsp_servers/jdtls/"
export VISUAL=nvim
export EDITOR=nvim

# eval "$(fnm env)"
eval "$(zoxide init zsh)"
# eval "`pip completion --zsh`"

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('/home/arminveres/anaconda3/bin/conda' 'shell.zsh' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/home/arminveres/anaconda3/etc/profile.d/conda.sh" ]; then
        . "/home/arminveres/anaconda3/etc/profile.d/conda.sh"
    else
        export PATH="/home/arminveres/anaconda3/bin:$PATH"
    fi
fi
unset __conda_setup
# <<< conda initialize <<<

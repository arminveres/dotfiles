# History
HISTFILE=~/.config/zsh/zsh_history
HISTSIZE=20000
SAVEHIST=20000
setopt appendhistory
setopt histexpiredupsfirst   # first delete duplicate commands if HISTFILE exceeds HISTSIZE
setopt histignoredups         # ignore duplicate commands
setopt histignorespace        # ignore commands starting with space
setopt histverify              # show command with history expansion to user before running it

export PATH=$HOME/bin:$HOME/.bin:$HOME/.local/bin:/usr/local/bin:$PATH
export JDTLS_HOME="/home/arminveres/.local/share/nvim/lsp_servers/jdtls/"
export VISUAL=nvim
export EDITOR=nvim

eval "$(zoxide init zsh)"
# eval "`pip completion --zsh`"

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('/home/arminveres/miniconda3/bin/conda' 'shell.zsh' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/home/arminveres/miniconda3/etc/profile.d/conda.sh" ]; then
        . "/home/arminveres/miniconda3/etc/profile.d/conda.sh"
    else
        export PATH="/home/arminveres/miniconda3/bin:$PATH"
    fi
fi
unset __conda_setup
# <<< conda initialize <<<


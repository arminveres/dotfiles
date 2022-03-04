# History
HISTFILE=~/.config/zsh/zsh_history
HISTSIZE=20000
SAVEHIST=20000
setopt APPEND_HISTORY
setopt HIST_EXPIRE_DUPS_FIRST # first delete duplicate commands if HISTFILE exceeds HISTSIZE
setopt HIST_IGNORE_DUPS       # ignore duplicate commands
setopt HIST_IGNORE_SPACE      # ignore commands starting with space
setopt HIST_VERIFY            # show command with history expansion to user before running it

export PATH=$HOME/bin:$HOME/.bin:$HOME/.local/bin:/usr/local/bin:$PATH
export JDTLS_HOME="/home/avee/.local/share/nvim/lsp_servers/jdtls/"
export VISUAL=nvim
export EDITOR=nvim
export RIPGREP_CONFIG_PATH=/home/arminveres/.config/ripgrep/ripgreprc
export MANGOHUD_CONFIGFILE=/home/arminveres/.config/MangoHud/MangoHud.conf

eval "$(zoxide init zsh)"

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

#THIS MUST BE AT THE END OF THE FILE FOR SDKMAN TO WORK!!!
export SDKMAN_DIR="$HOME/.sdkman"
[[ -s "$HOME/.sdkman/bin/sdkman-init.sh" ]] && source "$HOME/.sdkman/bin/sdkman-init.sh"

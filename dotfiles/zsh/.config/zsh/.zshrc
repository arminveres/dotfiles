# used because tmux was acting up, next time try: https://mbuffett.com/posts/setting-up-tmux-and-kitty-for-true-color-support/
# TERM=tmux-256color

# some useful options (man zshoptions)
setopt AUTO_CD
setopt EXTENDED_GLOB
setopt NOMATCH
setopt MENU_COMPLETE
setopt GLOB_DOTS
setopt INTERACTIVE_COMMENTS
# History
HISTFILE=$ZDOTDIR/zsh_history
HISTSIZE=20000
SAVEHIST=20000
setopt APPEND_HISTORY
setopt HIST_EXPIRE_DUPS_FIRST # first delete duplicate commands if HISTFILE exceeds HISTSIZE
setopt HIST_IGNORE_DUPS       # ignore duplicate commands
setopt HIST_IGNORE_SPACE      # ignore commands starting with space
setopt HIST_VERIFY            # show command with history expansion to user before running it
stty stop undef                # Disable ctrl-s to freeze terminal.
zle_highlight=('paste:none')

# beeping is annoying
unsetopt BEEP

# completions
autoload -Uz compinit
zstyle ':completion:*' menu select
# insensitive tab completion
zstyle ':completion:*' matcher-list '' 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=*' 'l:|=* r:|=*'
# groups completion commands
zstyle ':completion:*' group-name ''
# squeezes slashes: cd ~//Documents => cd ~/*/Documents
# shows current location type
zstyle ':completion:*:*:*:*:descriptions' format '%F{green}-- %d --%f'
zmodload zsh/complist
# compinit
_comp_options+=(globdots)      # Include hidden files.

autoload -U up-line-or-beginning-search
autoload -U down-line-or-beginning-search
zle -N up-line-or-beginning-search
zle -N down-line-or-beginning-search

# Colors
autoload -Uz colors && colors

# Useful Functions
source "$ZDOTDIR/functions.zsh"

# safe source cargo env
zsh_safe_source "$HOME/.cargo/env"

# Normal files to source
# Exports are needed before aliases
zsh_safe_source "vim_mode.zsh"
zsh_safe_source "aliases.zsh"

# prompt
# TODO:Maybe move it into repo anyway
zsh_download_plugin "woefe/git-prompt.zsh"
zsh_safe_source "./plugins/git-prompt.zsh/git-prompt.zsh"
zsh_safe_source "prompt.zsh"

# Plugins
zsh_add_plugin "zsh-users/zsh-autosuggestions"
zsh_add_plugin "zsh-users/zsh-syntax-highlighting"
zsh_add_plugin "hlissner/zsh-autopair"

# zsh_add_completion "esc/conda-zsh-completion" false
# For more plugins: https://github.com/unixorn/awesome-zsh-plugins
# More completions https://github.com/zsh-users/zsh-completions

# Key-bindings
bindkey -s '^o' 'ranger^M'
bindkey -s '^f' 'zi^M'
bindkey -s '^s' 'ncdu --color dark^M'
bindkey -s '^v' '$HOME/.config/zsh/scripts/fzf_vim.sh^M'
bindkey -s '^_' '$HOME/.config/zsh/scripts/conf.sh^M'

bindkey '^[[P' delete-char
bindkey "^p" up-line-or-beginning-search # Up
bindkey "^n" down-line-or-beginning-search # Down
bindkey "^k" up-line-or-beginning-search # Up
bindkey "^j" down-line-or-beginning-search # Down
# bindkey -r "^u"
bindkey -r "^d"

[ -f ~/.config/zsh/fzf.zsh ] && source ~/.config/zsh/fzf.zsh
# [ -f $ZDOTDIR/completion/_cht ] && fpath+="$ZDOTDIR/completion/"
# export FZF_DEFAULT_COMMAND='rg --hidden -l ""'
compinit

# Edit line in vim with ctrl-e:
autoload edit-command-line; zle -N edit-command-line
bindkey '^e' edit-command-line

[[ -s "/etc/grc.zsh" ]] && source /etc/grc.zsh

eval "$(zoxide init zsh)"

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('$HOME/miniconda3/bin/conda' 'shell.zsh' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "$HOME/miniconda3/etc/profile.d/conda.sh" ]; then
        . "$HOME/miniconda3/etc/profile.d/conda.sh"
    else
        export PATH="$HOME/miniconda3/bin:$PATH"
    fi
fi
unset __conda_setup
# <<< conda initialize <<<

#THIS MUST BE AT THE END OF THE FILE FOR SDKMAN TO WORK!!!
export SDKMAN_DIR="$HOME/.sdkman"
[[ -s "$HOME/.sdkman/bin/sdkman-init.sh" ]] && source "$HOME/.sdkman/bin/sdkman-init.sh"

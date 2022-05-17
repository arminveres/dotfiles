export ZDOTDIR=$HOME/.config/zsh

# used because tmux was acting up, next time try: https://mbuffett.com/posts/setting-up-tmux-and-kitty-for-true-color-support/
# TERM=tmux-256color

# some useful options (man zshoptions)
setopt AUTO_CD
setopt EXTENDED_GLOB
setopt NOMATCH
setopt MENU_COMPLETE
setopt GLOB_DOTS
setopt INTERACTIVE_COMMENTS
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

# Normal files to source
zsh_add_file "exports.zsh"
zsh_add_file "vim_mode.zsh"
zsh_add_file "aliases.zsh"

# prompt
# TODO:Maybe move it into repo anyway
zsh_download_plugin "woefe/git-prompt.zsh"
zsh_add_file "./plugins/git-prompt.zsh/git-prompt.zsh"
zsh_add_file "prompt.zsh"

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
bindkey -s '^s' 'ncdu^M'
bindkey -s '^v' 'nvim $(fzf)^M'
# BUG: doesn't workd as of yet, loads the file but the visible buffers stays empty
bindkey -s '^_' '~/.config/zsh/conf.sh^M'

bindkey '^[[P' delete-char
bindkey "^p" up-line-or-beginning-search # Up
bindkey "^n" down-line-or-beginning-search # Down
bindkey "^k" up-line-or-beginning-search # Up
bindkey "^j" down-line-or-beginning-search # Down
# bindkey -r "^u"
bindkey -r "^d"

[ -f ~/.config/zsh/fzf.zsh ] && source ~/.config/zsh/fzf.zsh
# [ -f $ZDOTDIR/completion/_cht ] && fpath+="$ZDOTDIR/completion/"
# ] && fpath+="$ZDOTDIR/completion/"
# export FZF_DEFAULT_COMMAND='rg --hidden -l ""'
compinit

# Edit line in vim with ctrl-e:
autoload edit-command-line; zle -N edit-command-line
bindkey '^e' edit-command-line

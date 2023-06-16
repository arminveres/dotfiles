#!/bin/env zsh
# used because tmux was acting up, next time try: https://mbuffett.com/posts/setting-up-tmux-and-kitty-for-true-color-support/
# TERM=tmux-256color

export HISTFILE="$ZDOTDIR/.zhistory"

# -------------------------------------------------------------------------------------------------
# Options
# -------------------------------------------------------------------------------------------------
# some useful options (man zshoptions)
setopt AUTO_CD
setopt AUTO_PUSHD
setopt EXTENDED_GLOB
setopt NOMATCH
setopt MENU_COMPLETE
setopt GLOB_DOTS
setopt INTERACTIVE_COMMENTS
setopt NO_CLOBBER             # do not allow truncating existing files e.g, with >, need to use >| instead
setopt APPEND_HISTORY
setopt HIST_EXPIRE_DUPS_FIRST # first delete duplicate commands if HISTFILE exceeds HISTSIZE
setopt HIST_IGNORE_ALL_DUPS   # ignore duplicate commands
setopt HIST_IGNORE_SPACE      # ignore commands starting with space
setopt HIST_VERIFY            # show command with history expansion to user before running it
stty stop undef               # Disable ctrl-s to freeze terminal.
zle_highlight=('paste:none')

# beeping is annoying
unsetopt BEEP
# for gods sake, finally able to fuzzy find the rest of the search
unsetopt menu_complete

# -------------------------------------------------------------------------------------------------
# Completions Configuration
# -------------------------------------------------------------------------------------------------
# FIXME: (aver) globbing is not case insensitive if sourced way above load completions
autoload -Uz compinit && compinit

zstyle ':completion:*' menu select
# insensitive tab completion
zstyle ':completion:*' matcher-list '' 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=*' 'l:|=* r:|=*'
# groups completion commands
zstyle ':completion:*' group-name ''
# squeezes slashes: cd ~//Documents => cd ~/*/Documents
#zstyle ':completion:*' squeeze-slashes true
# shows current location type
zstyle ':completion:*:*:*:*:descriptions' format '%F{green}-- %d --%f'

# Add colors from ls to completions
zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS}
zmodload zsh/complist
# compinit
_comp_options+=(globdots)      # Include hidden files.

[ -d "$ZDOTDIR"/completion ] && fpath=("$ZDOTDIR"/completion/ $fpath);
[ -d "$ZDOTDIR"/plugins/zsh-completions ] && fpath=("$ZDOTDIR"/plugins/zsh-completions/src $fpath);


autoload -U up-line-or-beginning-search && zle -N up-line-or-beginning-search
autoload -U down-line-or-beginning-search && zle -N down-line-or-beginning-search

# Colors
autoload -Uz colors && colors

# Useful Functions
source "$ZDOTDIR/functions.zsh"

# safe source cargo env
zsh_safe_source "$CARGO_HOME"/env

# Normal files to source
# Exports are needed before aliases
zsh_safe_source "vim_mode.zsh"
zsh_safe_source "aliases.zsh"
zsh_safe_source "fzf.zsh"


# Prompt
zsh_safe_source "./plugins/git-prompt.zsh/git-prompt.zsh"
zsh_safe_source "prompt.zsh"

# Plugins
zsh_add_plugin "zsh-users/zsh-autosuggestions"
zsh_add_plugin "zsh-users/zsh-syntax-highlighting"
zsh_add_plugin "hlissner/zsh-autopair"

# For more plugins: https://github.com/unixorn/awesome-zsh-plugins
# More completions https://github.com/zsh-users/zsh-completions

# Key-bindings
bindkey -s '^o' "ranger^M"
bindkey -s '^f' "zi^M"
bindkey -s '^s' "ncdu --color dark^M"
bindkey -s '^v' "$HOME/.config/zsh/scripts/fzf_vim.sh^M"
bindkey -s '^_' "$HOME/.config/zsh/scripts/conf.sh^M"

bindkey "^[[3~" delete-char
bindkey "^p" up-line-or-beginning-search # Up
bindkey "^n" down-line-or-beginning-search # Down
bindkey "^k" up-line-or-beginning-search # Up
bindkey "^j" down-line-or-beginning-search # Down
# bindkey -r "^u"
bindkey -r "^d"

# Edit line in vim with ctrl-e:
autoload edit-command-line; zle -N edit-command-line
bindkey '^e' edit-command-line

# fortune | cowsay -f blowfish | lolcat

[[ -f "$XDG_CONFIG_HOME"/X11/Xresources ]] && xrdb "$XDG_CONFIG_HOME"/X11/Xresources

# WARN: Zoxide removed this functionality and broke it for zsh.
if [ "$(command -v zoxide)" ]; then
    eval "$(zoxide init zsh)"
    unalias z
    function z () {
        __zoxide_z "$@"
    }
fi

# zsh_safe_source "scripts/mamba.zsh"

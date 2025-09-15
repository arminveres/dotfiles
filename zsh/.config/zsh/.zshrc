#!/usr/bin/env zsh
# used because tmux was acting up, next time try: https://mbuffett.com/posts/setting-up-tmux-and-kitty-for-true-color-support/
# TERM=xterm-256color

# History
export HISTSIZE=20000
export SAVEHIST=20000
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

# FIXME(aver): globbing is not case insensitive if sourced way above load completions
# autoload -Uz compinit

zstyle ':completion:*' menu select
# insensitive tab completion
zstyle ':completion:*' matcher-list '' 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=*' 'l:|=* r:|=*'
# groups completion commands
zstyle ':completion:*' group-name ''
# shows current location type
zstyle ':completion:*:*:*:*:descriptions' format '%F{green}-- %d --%f'
# squeezes slashes: cd ~//Documents => cd ~/*/Documents
# zstyle ':completion:*' squeeze-slashes true

# Add colors from ls to completions
zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS}
zmodload zsh/complist

_comp_options+=(globdots)      # Include hidden files.

fpath+=(
    "$ZDOTDIR/plugins/zsh-completions/src"
    "$ZDOTDIR/completion"
)

# Load completions: make all files found be used without asking, use the option -u
# use -C for a compiled version, blazingly fast!!!
autoload -Uz compinit; compinit
autoload -Uz colors; colors

# ==================================================================================================
# Sourcing plugins and custom scripts
# ==================================================================================================

# Useful Functions
source "$ZDOTDIR/functions.zsh"

# Normal files to source
# Exports are needed before aliases
source "$ZDOTDIR/vim_mode.zsh"
source "$ZDOTDIR/aliases.zsh"
source "$ZDOTDIR/fzf.zsh"
source "$ZDOTDIR/git.zsh"

# Prompt
source "$ZDOTDIR/plugins/git-prompt.zsh/git-prompt.zsh"
source "$ZDOTDIR/prompt.zsh"

# Plugins
source "$ZDOTDIR/plugins/zsh-autosuggestions/zsh-autosuggestions.plugin.zsh"
source "$ZDOTDIR/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.plugin.zsh"
source "$ZDOTDIR/plugins/zsh-autopair/zsh-autopair.plugin.zsh"
# For more plugins: https://github.com/unixorn/awesome-zsh-plugins

# ==================================================================================================
# Key-bindings
# ==================================================================================================
bindkey -s '^v' "^U$ZDOTDIR/scripts/fzf_vim.sh^M"
bindkey -s '^_' "^U$ZDOTDIR/scripts/conf.sh^M"
bindkey -s '^f' "^Ucdi^M"
# bindkey -s '^s' "^Utmux-sessionizer^M"

bindkey "^[[3~" delete-char
bindkey '^o' end-of-line
# bindkey -r "^d"
# bindkey -r "^u"

# search using a prefix, e.g., `cd` only searches history including cd
autoload -U up-line-or-beginning-search && zle -N up-line-or-beginning-search
autoload -U down-line-or-beginning-search && zle -N down-line-or-beginning-search
bindkey "^p" up-line-or-beginning-search # Up
bindkey "^n" down-line-or-beginning-search # Down
# Edit line in vim with ctrl-e:
autoload edit-command-line; zle -N edit-command-line
bindkey '^e' edit-command-line

# ================================================================================================
# Distro specifig setup
# ================================================================================================
if [[ "$(uname)" == "Linux" ]] && [[ -n "$DIST" ]]; then
    case "$DIST" in
    Ubuntu | Debian)
        alias nala='sudo nala'
        alias upd='sudo apt update && sudo apt upgrade'
        ;;
    Fedora) # echo Fedora
        alias dnf='sudo dnf'
        alias din='dnf install'
        alias dup='dnf upgrade'
        alias doffup='dnf offline-upgrade download -y && dnf offline-upgrade reboot'
        ;;
    NixOS) source "$ZDOTDIR/nix.zsh" ;;
    *) ;;
    esac
fi

if command -v direnv >/dev/null; then
    eval "$(direnv hook zsh)"
fi

# WARN(aver): Zoxide removed this functionality and broke it for zsh.
if command -v zoxide >/dev/null; then
    eval "$(zoxide init zsh --cmd cd)"
fi

if command -v keychain >/dev/null; then
    eval "$(keychain --noask --quiet --eval id_rsa gh)"
fi

ulimit -n $((2 ** 16))

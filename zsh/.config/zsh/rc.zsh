#!/usr/bin/env zsh
#
# Interactive shell configuration. This is the entry point sourced from the
# generated .zshrc and pulls in everything else.

# Startup timing, using zsh builtins so we don't fork anything.
zmodload zsh/datetime
zsh_start_time=$EPOCHREALTIME

ZMODULES="$ZDOTDIR/modules"

source "$ZDOTDIR/options.zsh"
source "$ZDOTDIR/plugins.zsh"

# ==================================================================================================
# Custom modules
# ==================================================================================================
source "$ZMODULES/dotdot.zsh"
source "$ZMODULES/functions.zsh"
source "$ZMODULES/git.zsh"
source "$ZMODULES/prompt.zsh"

# Exports are needed before aliases
source "$ZDOTDIR/aliases.zsh"
source "$ZDOTDIR/distro.zsh"

# ==================================================================================================
# Key-bindings
# ==================================================================================================
source "$ZMODULES/keybinds.zsh"

# https://github.com/jeffreytse/zsh-vi-mode#execute-extra-commands
function _zvm_keybinds {
    # search using a prefix, e.g., `cd` only searches history including cd
    autoload -U up-line-or-beginning-search
    zle -N up-line-or-beginning-search
    bindkey "^p" up-line-or-beginning-search

    autoload -U down-line-or-beginning-search
    zle -N down-line-or-beginning-search
    bindkey "^n" down-line-or-beginning-search

    # Edit line in vim with ctrl-e:
    autoload edit-command-line
    zle -N edit-command-line
    bindkey '^e' edit-command-line

    command -v fzf >/dev/null && source <(fzf --zsh)
}
zvm_after_init_commands+=(_zvm_keybinds)

# ==================================================================================================
# Theming
# ==================================================================================================
ZSH_THEME_GIT_PROMPT_UNMERGED="%{$fg[red]%}"
ZSH_THEME_GIT_PROMPT_STAGED="%{$fg[green]%}●"
ZSH_THEME_GIT_PROMPT_UNSTAGED="%{$fg[red]%}"
ZSH_THEME_GIT_PROMPT_CLEAN="%{$fg_bold[green]%}"

# ==================================================================================================
# END
# ==================================================================================================
# Machine local, untracked overrides
[[ -e "$ZDOTDIR/work.zsh" ]] && source "$ZDOTDIR/work.zsh"

printf 'Shell init time: %.0f ms\n' $(( (EPOCHREALTIME - zsh_start_time) * 1000 ))

if [[ -n "$SSH_CONNECTION" && -z "$TMUX" ]]; then
    # Set window name to hostname when in SSH
    printf '\033k%s\033\\' "$(hostname -s)"
fi

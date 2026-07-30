#!/usr/bin/env zsh
#
# Completion system initialization and styling.
# This is sourced early (from the `completionInit` slot) so that `compdef` calls
# from plugins keep working.

_comp_options+=(globdots) # include hidden files

fpath+=(
    "$ZDOTDIR/completion"
    "$ZDOTDIR/plugins/zsh-completions/src"
)

autoload -Uz compinit

# Glob qualifiers:
#   N   : nullglob (don't error if the file is missing)
#   .   : plain files only
#   mh-24: modified less than 24 hours ago
#
# NOTE(aver): this *must* be a plain glob expansion. Inside `[[ ... ]]` zsh does
# not perform filename generation, so a qualifier there silently evaluates to a
# non-empty literal string and the cache would be rebuilt on every startup.
zsh_compdump_fresh=("$ZSH_COMPLETION_DUMP"(N.mh-24))

if (( $#zsh_compdump_fresh )); then
    # Cache is fresh -> fast load, skipping all security checks.
    #   -C: skip all security checks, trust the dump file
    compinit -C -d "$ZSH_COMPLETION_DUMP"
else
    mkdir -p "${ZSH_COMPLETION_DUMP:h}"

    # Cache is old or missing -> rebuild.
    #   -i: ignore insecure directories (don't ask)
    #   -u: use insecure directories silently
    #   -d: dump path
    compinit -i -u -d "$ZSH_COMPLETION_DUMP"

    # Reset the modification time to prevent compaudit loops.
    touch "$ZSH_COMPLETION_DUMP"

    # Compile for speed. Only needed right after a rebuild.
    zcompile "$ZSH_COMPLETION_DUMP" &!
fi

unset zsh_compdump_fresh

# -------------------------------------------------------------------------------------------------
# Styling
# -------------------------------------------------------------------------------------------------
# shows current location type
zstyle ':completion:*:*:*:*:descriptions' format '%F{green}-- %d --%f'

zstyle ':completion:*' menu select
# case insensitive tab completion
zstyle ':completion:*' matcher-list '' 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=*' 'l:|=* r:|=*'
# groups completion commands
zstyle ':completion:*' group-name ''
# squeezes slashes: cd ~//Documents => cd ~/*/Documents
# zstyle ':completion:*' squeeze-slashes true

# Add colors from ls to completions
zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS}
zmodload zsh/complist

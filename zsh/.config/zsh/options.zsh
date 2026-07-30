#!/usr/bin/env zsh
#
# Shell options and history configuration (man zshoptions)

# -------------------------------------------------------------------------------------------------
# History
# -------------------------------------------------------------------------------------------------
HISTSIZE=20000
SAVEHIST=20000
HISTFILE="$ZDOTDIR/.zsh_history"
mkdir -p "${HISTFILE:h}"

setopt APPEND_HISTORY
setopt HIST_EXPIRE_DUPS_FIRST # first delete duplicate commands if HISTFILE exceeds HISTSIZE
setopt HIST_IGNORE_ALL_DUPS   # ignore duplicate commands
setopt HIST_IGNORE_SPACE      # ignore commands starting with a space
setopt HIST_VERIFY            # show command with history expansion before running it, e.g. !x

# -------------------------------------------------------------------------------------------------
# Options
# -------------------------------------------------------------------------------------------------
setopt AUTO_CD
setopt AUTO_PUSHD           # make cd push the old directory onto the directory stack
setopt GLOB_DOTS            # match hidden files
setopt NOMATCH              # error out on invalid patterns in the arg list
setopt INTERACTIVE_COMMENTS # allow comments in an interactive shell
setopt NO_CLOBBER           # disallow truncating existing files with `>`, use `>|` instead

# Treat `#', `~' and `^' as part of patterns for filename generation.
# setopt EXTENDED_GLOB

unsetopt BEEP           # beeping is annoying
unsetopt MENU_COMPLETE  # allow fuzzy finding the rest of the search

zle_highlight=('paste:none')

# Disable ctrl-s freezing the terminal.
stty stop undef

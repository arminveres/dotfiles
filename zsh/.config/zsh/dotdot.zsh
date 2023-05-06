#!/bin/env zsh
#
# Enables expansion of ... and higher
# Taken from: https://stackoverflow.com/questions/23456873/multi-dot-paths-in-zsh-like-cd

function expand-dots() {
    local MATCH
    if [[ $LBUFFER =~ '\.\.\.+' ]]; then
        LBUFFER=$LBUFFER:fs%\.\.\.%../..%
    fi
}

function expand-dots-then-expand-or-complete() {
    zle expand-dots
    zle expand-or-complete
}

function expand-dots-then-accept-line() {
    zle expand-dots
    zle accept-line
}

zle -N expand-dots
zle -N expand-dots-then-expand-or-complete
zle -N expand-dots-then-accept-line
bindkey '^I' expand-dots-then-expand-or-complete
bindkey '^M' expand-dots-then-accept-line

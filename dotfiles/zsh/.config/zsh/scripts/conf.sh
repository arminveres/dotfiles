#!/bin/bash

# reads in a config name
config=`cat $HOME/.config/zsh/scripts/config_locations | fzf`

# NOTE: opens config folder instead of the config itself
# TODO: open first file directly

if [[ -n $config ]]; then
    nvim ~/.config/$config
else
    printf "Nothing selected!\n"
fi


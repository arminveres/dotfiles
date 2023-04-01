#!/bin/bash

# reads in a config name
config=$(fzf <"$HOME"/.config/zsh/scripts/config_locations)

# TODO: add check of config location
# loc=$XDG_CONFIG_HOME/$config

# NOTE: opens config folder instead of the config itself
if [[ -n $config ]]; then
    nvim -c "cd ~/.config/$config/" -c 'Telescope find_files'
else
    printf "Nothing selected!\n"
fi

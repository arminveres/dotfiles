#!/bin/bash

config=$(fd --max-depth 1 . "$XDG_CONFIG_HOME" | fzf)

if [[ -n $config ]]; then
    nvim -c "cd $config/" -c 'Telescope find_files'
else
    printf "Nothing selected!\n"
fi

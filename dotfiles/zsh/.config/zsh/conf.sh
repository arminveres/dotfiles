#!/bin/bash

# reads in a config name
config=`cat ~/.config/zsh/config_locations | fzf`

# NOTE: opens config folder instead of the config itself
# TODO: open first file directly
nvim ~/.config/$config

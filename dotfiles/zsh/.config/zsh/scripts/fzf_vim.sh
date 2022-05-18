#!/bin/bash

output=`fzf`

if [[ -n $output ]]; then
    nvim $output
else
    printf "Nothing selected!\n"
fi


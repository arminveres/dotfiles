#!/bin/bash

# General nvim fzf selector wrapper, handles empty input, so nvim is not just
# opened with an empty buffer.

output=$(fzf)

if [[ -n $output ]]; then
    nvim $output
else
    printf "Nothing selected!\n"
fi


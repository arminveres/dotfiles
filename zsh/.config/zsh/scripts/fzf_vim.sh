#!/usr/bin/env bash

# General nvim fzf selector wrapper, handles empty input, so nvim is not just
# opened with an empty buffer.
# TODO: add options to add/delete new entries

output=$(fzf)

if [[ -n $output ]]; then
	nvim "$output"
else
	printf "Nothing selected!\n"
fi

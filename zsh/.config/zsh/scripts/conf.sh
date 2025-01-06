#!/usr/bin/env bash
set -e
if command -v fd >/dev/null; then
	FDCMD=fd
elif command -v fdfind >/dev/null; then
	FDCMD=fdfinf
else
	echo "ERROR: no fd-find command available"
fi

# capture files in variable
sel_conf=$("$FDCMD" --max-depth 1 . "$XDG_CONFIG_HOME" | fzf)

if [[ -n $sel_conf ]]; then
	nvim -c "chdir $sel_conf" #-c "Telescope find_files search_dirs=$sel_conf"
else
	echo "INFO: Nothing selected!"
fi

#!/usr/bin/env bash
set -e

case "$DISTRO" in
Debian | Ubuntu) fdcmd=fdfind ;;
*) fdcmd=fd ;;
esac

# capture files in variable
sel_conf=$("$fdcmd" --max-depth 1 . "$XDG_CONFIG_HOME" | fzf)

if [[ -n $sel_conf ]]; then
	nvim -c "chdir $sel_conf" # -c "Telescope find_files"
else
	printf "Nothing selected!\n"
fi

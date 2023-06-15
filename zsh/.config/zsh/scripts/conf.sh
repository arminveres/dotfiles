#!/bin/bash

case "$(lsb_release -i | awk '{print $3}')" in
Fedora) # echo Ubuntu
	fdcmd=fd
	;;
Debian | Ubuntu) # echo Ubuntu
	fdcmd=fdfind
	;;
esac

# capture files in variable
list_of_configs=$(
	"$fdcmd" --max-depth 1 . "$XDG_CONFIG_HOME" | fzf
)

if [[ -n $list_of_configs ]]; then
	nvim -c "cd $list_of_configs/" -c 'Telescope find_files'
else
	printf "Nothing selected!\n"
fi

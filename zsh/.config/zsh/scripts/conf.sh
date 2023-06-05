#!/bin/bash

case "$(lsb_release -i | awk '{print $3}')" in
    Fedora) # echo Ubuntu
        fdcmd=fd
        ;;
    Debian) # echo Ubuntu
        fdcmd=fdfind
        ;;
esac

config=$($fdcmd --max-depth 1 . "$XDG_CONFIG_HOME" | fzf)

if [[ -n $config ]]; then
    nvim -c "cd $config/" -c 'Telescope find_files'
else
    printf "Nothing selected!\n"
fi

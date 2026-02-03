#!/usr/bin/env zsh

function convert_heic_to_jpg {
    if ! command -v magick > /dev/null; then
        printf "magic missing, aborting"
        return
    fi
    for file in *.(heic|HEIC); do
        echo $file
        magick $file ${file/%.(heic|HEIC)/.jpg};
    done
    if [[ $1 == "-d" ]]; then
        rm -f *.HEIC
        rm -f *.heic
    fi
}

function convert_webp_to_png {
    for x in `\ls -1 *.webp`; do
        dwebp {} -o ${x%.*}.png ::: $x;
    done
}

function open {
    if [[ $(uname) == 'Linux' ]]; then
        xdg-open "$1" & disown >/dev/null
    elif [[ $(uname) == 'Darwin' ]]; then
        open "$1" & disown
    fi
}

# find thermal info loc
function find_thermal_zone {
    for i in /sys/class/hwmon/hwmon*/temp*_input; do
        echo "$(<$(dirname $i)/name): $(cat ${i%_*}_label 2>/dev/null || echo $(basename ${i%_*})) $(readlink -f $i)";
    done
}

#
# Run something in the background using tmux, alternative could use
# `nohup $command & disown`, but this way nothing is generated
#
function runbg {
    tmux new -s $1 -d $@
}

#
# Verbosely remove directories recursively
#
function rmv() {
    printf "Removing:\n"
    for val in "$@"; do
        printf "  %s\n" $(readlink --canonicalize "$val")
    done
    rm --recursive --force "$@"
}

# =================================================================================================
# Manual ZSH plugin manages
# =================================================================================================

# Function to source files if they exist
function zsh_safe_source {
    [ -f "$ZDOTDIR/$1" ] && source "$ZDOTDIR/$1"
}

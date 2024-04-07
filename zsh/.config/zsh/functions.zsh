#!/bin/env zsh

function convert_heic_to_jpg {
    for file in *.(heic|HEIC); do
        echo $file
        heif-convert $file ${file/%.(heic|HEIC)/.jpg};
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

function git_update_project_in_dir {
    for file in ./*/;
    do
        echo "$file" && \
            cd $file && \
            git pull && \
            cd -
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

# @brief run something in the background using tmux, alternative could use
# `nohup $command & disown`, but this way nothing is generated
function runbg {
    tmux new -s $1 -d $@
}

# neat directly viewer and changer for git worktrees
function wtz {
    dir=$(git worktree list | fzf | awk '{print $1}')
    if [[ -n $dir ]]; then
        z $dir
    else
        echo "Nothing selected"
    fi
}

function rebuild() {
    word="$(uname --nodename)"
    IFS='-' read -r part1 part2 <<< "$word"
    sudo nixos-rebuild switch --flake "$HOME/nix-conf/#$part2"
}

# =================================================================================================
# Manual ZSH plugin manages
# =================================================================================================

# Function to source files if they exist
function zsh_safe_source {
    [ -f "$ZDOTDIR/$1" ] && source "$ZDOTDIR/$1"
}

# add normal plugins
function zsh_add_plugin {
    PLUGIN_NAME=$(echo $1 | cut -d "/" -f 2)
    if [ -d "$ZDOTDIR/plugins/$PLUGIN_NAME" ]; then
        # For plugins
        zsh_safe_source "plugins/$PLUGIN_NAME/$PLUGIN_NAME.plugin.zsh" || \
            zsh_safe_source "plugins/$PLUGIN_NAME/$PLUGIN_NAME.zsh"
    else
        git clone "https://github.com/$1.git" "$ZDOTDIR/plugins/$PLUGIN_NAME"
    fi
}

# download plugins but do not source them => irregular plugins
function zsh_download_plugin {
    PLUGIN_NAME=$(echo $1 | cut -d "/" -f 2)
    if [ -d "$ZDOTDIR/plugins/$PLUGIN_NAME" ]; then
        # For plugins
    else
        git clone "https://github.com/$1.git" "$ZDOTDIR/plugins/$PLUGIN_NAME"
    fi
}

# Add completion plugins
function zsh_add_completion {
    PLUGIN_NAME=$(echo $1 | cut -d "/" -f 2)
    if [ -d "$ZDOTDIR/plugins/$PLUGIN_NAME" ]; then
        # For completions
        completion_file_path=$(ls $ZDOTDIR/plugins/$PLUGIN_NAME/_*)
        fpath+="$(dirname "${completion_file_path}")"
        zsh_safe_source "plugins/$PLUGIN_NAME/$PLUGIN_NAME.plugin.zsh"
    else
        git clone "https://github.com/$1.git" "$ZDOTDIR/plugins/$PLUGIN_NAME"
        fpath+=$(ls $ZDOTDIR/plugins/$PLUGIN_NAME/_*)
        [ -f $ZDOTDIR/.zccompdump ] && $ZDOTDIR/.zccompdump
    fi
    completion_file="$(basename "${completion_file_path}")"
    if [ "$2" = true ] && compinit "${completion_file:1}"
}

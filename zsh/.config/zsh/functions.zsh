#!/usr/bin/env zsh

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

# =================================================================================================
# Nix specific functions
# =================================================================================================

function lrebuild() {
    case "$(uname)" in
        Linux)
            sudo nixos-rebuild switch --flake "$FLAKE#$(hostname)"
            ;;
        Darwin)
            darwin-rebuild switch --flake "$HOME/nix-conf#armins-macbook"
            ;;
    esac
}

# @brief rebuilds the system on my remote server
function rrebuild() {
    nixos-rebuild switch \
        --flake "$FLAKE#$(hostname)" \
        --build-host arminserver-zt \
        --use-remote-sudo
}

function flakify() {
  if [ ! -e flake.nix ]; then
    nix flake new -t github:nix-community/nix-direnv .
  elif [ ! -e .envrc ]; then
    echo "use flake" > .envrc
    direnv allow
  fi
  ${EDITOR:-vim} flake.nix
}

# =================================================================================================
# Manual ZSH plugin manages
# =================================================================================================

# Function to source files if they exist
function zsh_safe_source {
    [ -f "$ZDOTDIR/$1" ] && source "$ZDOTDIR/$1"
}

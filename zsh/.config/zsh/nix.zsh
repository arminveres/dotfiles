#!/usr/bin/env zsh
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

# Create a flake out of a directory/repository
function flakify() {
    if [ ! -e flake.nix ]; then
        nix flake new -t github:nix-community/nix-direnv .
    elif [ ! -e .envrc ]; then
        echo "use flake" >.envrc
        direnv allow
    fi
    ${EDITOR:-vim} flake.nix
}

# Update flake based nix setup and create a commit with the date and time
function nxup() {
    local GIT_REPO=$HOME/nix-conf

    printf "\n<<<< Running NixOS system update >>>>\n\n"
    if ! nh os switch --update; then
        printf "Update failed"
        return
    fi

    printf "\n\n<<<< Creating commit for update >>>>\n\n"
    pushd $GIT_REPO
    git commit $GIT_REPO/flake.lock \
        -m "build(flake): update lockfile $(date -u +%Y-%m-%dT%H:%M%Z)"
    if [[ $? -ne 0 ]]; then
        git commit --amend \
            -m "build(flake): update lockfile $(date -u +%Y-%m-%dT%H:%M%Z)"
    fi
    popd
}

alias nxfclean='nix-collect-garbage -d && nix-store --optimize'
alias nxclean='nix-collect-garbage && nix-store --optimize'

# FIXME(aver): for some reason, this does get set automatically
# export LD_LIBRARY_PATH="$NIX_LD_LIBRARY_PATH"

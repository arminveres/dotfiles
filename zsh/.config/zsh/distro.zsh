#!/usr/bin/env zsh
#
# Distribution specific aliases and functions.

# Pretty print log messages
function _log() {
    printf "\n<<<< $1 >>>>\n\n"
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

# Commit the updated flake.lock with a timestamped message.
function _nxup_commit() {
    local git_repo="$HOME/nix-conf"
    local message="$1"

    _log "Creating commit for update"
    pushd "$git_repo" >/dev/null || return
    if ! git commit "$git_repo/flake.lock" -m "$message"; then
        git commit --amend -m "$message"
    fi
    popd >/dev/null || return
    _log "Update successful!"
}

[[ "$(uname)" == "Linux" && -n "$DISTRO" ]] || return 0

case "$DISTRO" in
Ubuntu | Debian)
    alias nala='sudo nala'
    alias upd='sudo apt update && sudo apt upgrade'

    # Update the home-manager setup and create a commit with the date and time
    function nxup() {
        _log "Running Nix Home-Manager update"
        if ! nh home switch --configuration ubuntu-cli --update; then
            _log "Update failed!"
            return
        fi
        _nxup_commit "build(flake): update lockfile (home-manager) $(date -u +%Y-%m-%dT%H:%M%Z)"
    }
    ;;

Fedora)
    alias dnf='sudo dnf'
    alias din='dnf install'
    alias dup='dnf upgrade'
    alias doffup='dnf offline-upgrade download -y && dnf offline-upgrade reboot'
    ;;

NixOS)
    # Rebuild the system on my remote server
    function rrebuild() {
        nixos-rebuild switch \
            --flake "$FLAKE#$(hostname)" \
            --build-host arminserver-zt \
            --use-remote-sudo
    }

    # Update the flake based nix setup and create a commit with the date and time
    function nxup() {
        _log "Running NixOS system update"
        if ! nh os boot --update; then
            _log "Update failed!"
            return
        fi
        _nxup_commit "build(flake): update lockfile $(date -u +%Y-%m-%dT%H:%M%Z)"
    }
    ;;
esac

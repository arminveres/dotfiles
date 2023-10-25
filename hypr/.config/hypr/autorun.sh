#!/bin/env bash
# set -ev
# set -o pipefail

# run "program [some arguments]"
function run {
    if ! pgrep -f "$1"; then
        "$@" &
    fi
}

# export "$(gnome-keyring-daemon --start --components=pkcs11,secrets,ssh,gpg)"
# gnome-keyring-daemon --daemonize --login

run /usr/bin/lxpolkit
run udiskie --tray --notify
run nm-applet
run pasystray
run solaar --window hide
# run blueman-manager
# run corectrl

tmux new -s daemon -d

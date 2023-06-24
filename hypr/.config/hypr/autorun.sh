#!/bin/env bash

set -ev

# run "program [some arguments]"
run() {
    if ! pgrep -f "$1"; then
        "$@" &
    fi
}

export "$(gnome-keyring-daemon --start --components=pkcs11,secrets,ssh,gpg)"
gnome-keyring-daemon --daemonize --login
tmux new -s daemon -d

# run /usr/libexec/polkit-gnome-authentication-agent-1
run /usr/bin/lxpolkit
run udiskie --tray --notify
run blueman-manager
run nm-applet
run pasystray
run corectrl
run solaar --window hide

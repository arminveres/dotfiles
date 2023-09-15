#!/bin/env bash

# run "program [some arguments]"
run() {
    if ! pgrep -f "$1"; then
        "$@" &
    fi
}

# Security related startups
eval "$(gnome-keyring-daemon --start --components=pkcs11,secrets,ssh,gpg)"
export "$(gnome-keyring-daemon --start --components=pkcs11,secrets,ssh,gpg)"
gnome-keyring-daemon --daemonize --login
run /usr/libexec/polkit-gnome-authentication-agent-1

# Tray application
run udiskie --tray --notify
run blueman-manager
run nm-applet
run pasystray
run solaar --window hide

run xinput --set-prop 'Logitech MX Master 3' 'libinput Accel Profile Enabled' 0, 1
run xinput --set-prop 'Logitech G Pro' 'libinput Accel Profile Enabled' 0, 1
run xinput --set-prop 'pointer:Logitech G305' 'libinput Accel Profile Enabled' 0, 1

run nitrogen --restore
run picom --daemon --config ~/.config/picom/picom.conf

run thunderbird
run firefox

# Laptop/Notebook specific settings
if uname --nodename | grep -q notebook; then
    run xss-lock --transfer-sleep-lock -- i3lock-blur --nofork # locks screen when closing the lid
    if ! xinput | grep -q M60 && ! xinput | grep -q Sofle; then
        # only swap ctrl and caps lock, if we are not connected to already pre-swapped keyboards
        # setxkbmap -option 'ctrl:swapcaps,altwin:swap_alt_win'
        xremap "$XDG_CONFIG_HOME"/xremap/config.yml
    fi
    xinput set-prop 'ELAN0672:00 04F3:3187 Touchpad' 'libinput Tapping Enabled' 1
    xinput set-prop 'ELAN0672:00 04F3:3187 Touchpad' 'libinput Natural Scrolling Enabled' 1
    flatpak run com.github.wwmm.easyeffects
else # only run on desktop
    # run autorandr --load secoff
    run corectrl
    run solaar --window hide
fi

# create a tmux session in the background so that tmux is faster on a cold start
tmux new -s daemon -d
setxkbmap eu

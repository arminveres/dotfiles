#!/bin/env bash

# run "program [some arguments]"
function run {
	if ! pgrep -f "$1"; then
		"$@" &
	fi
}

# Security related startups
systemctl --user start gnome-keyring-daemon.service
gnome-keyring-daemon --daemonize --login
run /usr/libexec/polkit-gnome-authentication-agent-1

# Repeat rate for Xorg
xset r rate 250 25
xset s 3600 3600
xset dpms 3600 3600 3600
run xss-lock --transfer-sleep-lock -- i3lock-blur --nofork # locks screen when closing the lid

# Tray application
run udiskie --tray --notify
run nm-applet
run pasystray
run solaar --window hide
run thunar --daemon

run xinput --set-prop 'Logitech MX Master 3' 'libinput Accel Profile Enabled' 0, 1
run xinput --set-prop 'Logitech G Pro' 'libinput Accel Profile Enabled' 0, 1
run xinput --set-prop 'pointer:Logitech G305' 'libinput Accel Profile Enabled' 0, 1

# Laptop/Notebook specific settings
if uname --nodename | grep -q notebook; then
	# WARN(aver): This block needs to first on the laptop
	run nitrogen --restore
	run picom --daemon --config ~/.config/picom/picom.conf
	# create a tmux session in the background so that tmux is faster on a cold start
	tmux new -s daemon -d

	xinput set-prop 'ELAN0672:00 04F3:3187 Touchpad' 'libinput Tapping Enabled' 1
	xinput set-prop 'ELAN0672:00 04F3:3187 Touchpad' 'libinput Natural Scrolling Enabled' 1
	if ! xinput | grep -q M60 && ! xinput | grep -q Sofle; then
		# only swap ctrl and caps lock, if we are not connected to already pre-swapped keyboards
		# setxkbmap -option 'ctrl:swapcaps,altwin:swap_alt_win'
		xremap "$XDG_CONFIG_HOME"/xremap/config.yml
	fi
	# flatpak run com.github.wwmm.easyeffects
else # only run on desktop
	# run blueman-manager
	run corectrl
	run solaar --window hide

	# Running autorandr is too slow on startup and messes everything up
	run "$HOME/.screenlayout/default.sh"

	# WARN(aver): this block below needs to run later than on the laptop
	# create a tmux session in the background so that tmux is faster on a cold start
	tmux new -s daemon -d
	setxkbmap eu
	run nitrogen --restore
	run picom --daemon --config "$XDG_CONFIG_HOME"/picom/picom.conf
fi

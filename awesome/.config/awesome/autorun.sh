#!/bin/sh

# run "program [some arguments]"
run() {
	if ! pgrep -f "$1"; then
		"$@" &
	fi
}

setxkbmap de us
export "$(gnome-keyring-daemon --start --components=pkcs11,secrets,ssh,gpg)"
gnome-keyring-daemon --daemonize --login

run /usr/libexec/polkit-gnome-authentication-agent-1
run udiskie --tray --notify
run blueman-manager
run nm-applet
run pasystray
run xinput --set-prop 'Logitech MX Master 3' 'libinput Accel Profile Enabled' 0, 1
run xinput --set-prop 'Logitech G Pro' 'libinput Accel Profile Enabled' 0, 1
run xinput --set-prop 'pointer:Logitech G305' 'libinput Accel Profile Enabled' 0, 1

# Laptop/Notebook specific settings
if [[ ! -z $(uname --nodename | grep notebook) ]]; then
	if [[ -z $(xinput | grep M60)  ]]; then
	setxkbmap -option 'ctrl:swapcaps,altwin:swap_alt_win'
	fi
	xinput set-prop 'ELAN0672:00 04F3:3187 Touchpad' 'libinput Tapping Enabled' 1
	xinput set-prop 'ELAN0672:00 04F3:3187 Touchpad' 'libinput Natural Scrolling Enabled' 1
	run xss-lock --transfer-sleep-lock -- i3lock-blur --nofork # locks screen when clising the lid
else
	run autorandr --load secoff
	run corectrl
	# run ddccontrol
fi

run nitrogen --restore
run picom --daemon --experimental-backend --config ~/.config/picom/picom.conf

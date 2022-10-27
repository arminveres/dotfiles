#!/bin/sh

# run "program [some arguments]"
run() {
  if ! pgrep -f "$1" ;
  then
    "$@"&
  fi
}

setxkbmap de us
export $(gnome-keyring-daemon --start --components=pkcs11,secrets,ssh,gpg)
gnome-keyring-daemon --daemonize --login

run nitrogen --restore
run /usr/libexec/polkit-gnome-authentication-agent-1
run picom --daemon --experimental-backend --config ~/.config/picom/picom.conf
run udiskie --tray --notify
run blueman-manager
run corectrl
run nm-applet
run pasystray
run xrandr --output DisplayPort-1 --primary --mode 3440x1440 --rate 144
run xrandr --output HDMI-A-0 --mode 1920x1080 --rate 70 --right-of DisplayPort-1 --rotate right
run xinput --set-prop 'Logitech MX Master 3' 'libinput Accel Profile Enabled' 0, 1
run xinput --set-prop 'Logitech G Pro' 'libinput Accel Profile Enabled' 0, 1
run xinput --set-prop 'pointer:Logitech G305' 'libinput Accel Profile Enabled' 0, 1

# Laptop/Notebook specific settings
if [[ ! -z `uname --nodename | grep notebook` && -z `xinput | grep M60` ]]; then
  setxkbmap -option 'ctrl:swapcaps,altwin:swap_alt_win'
  xinput set-prop 'ELAN0672:00 04F3:3187 Touchpad' 'libinput Tapping Enabled' 1
  xinput set-prop 'ELAN0672:00 04F3:3187 Touchpad' 'libinput Natural Scrolling Enabled' 1
  run xss-lock --transfer-sleep-lock -- i3lock-blur --nofork # locks screen when clising the lid
fi

#!/bin/sh

run() {
  if ! pgrep -f "$1" ;
  then
    "$@"&
  fi
}

# run "program [some arguments]"
eval $(gnome-keyring-daemon --start --login --daemonize --components=pkcs11,secrets,ssh,gpg)
run picom --daemon --experimental-backend --config ~/.config/picom/picom.conf
run udiskie --tray --notify
run blueman-manager
run corectrl
run nm-applet
run pasystray
run nitrogen --restore
run xrandr --output DisplayPort-1 --primary --mode 3440x1440 --rate 144
run xrandr --output HDMI-A-0 --mode 1920x1080 --rate 70 --right-of DisplayPort-1 --rotate right
run xinput --set-prop 'Logitech MX Master 3' 'libinput Accel Profile Enabled' 0, 1
run xinput --set-prop 'Logitech G Pro' 'libinput Accel Profile Enabled' 0, 1


#!/usr/bin/env bash

# Terminate already running bar instances
killall -q polybar
# If all your bars have ipc enabled, you can also use polybar-msg cmd quit

case "$(uname -n)" in
    "fedoraarmin")
        # Launch bar1 and bar2
        echo "---" | tee -a /tmp/polybar1.log /tmp/polybar2.log
        echo "workstation fedoraarmin"| tee -a /tmp/polybar1.log /tmp/polybar2.log
        polybar armin_ultrawide 2>&1 | tee -a /tmp/polybar1.log & disown
        polybar armin2 2>&1 | tee -a /tmp/polybar2.log & disown
        polybar systray 2>&1 | tee -a /tmp/polybar3.log & disown
    ;;
    "fedora-notebook-armin")
        # Launch only armin_bar1
        echo "---" | tee -a /tmp/polybar1.log
        echo "fedora-notebook-armin"| tee -a /tmp/polybar1.log
        polybar armin_laptop1 2>&1 | tee -a /tmp/polybar1.log & disown
    ;;
    *) echo "default"
        # Launch bar1 and bar2
        echo "---" | tee -a /tmp/polybar1.log /tmp/polybar2.log
        echo "default" | tee -a /tmp/polybar1.log /tmp/polybar2.log
        polybar armin1 2>&1 | tee -a /tmp/polybar1.log & disown
        polybar armin2 2>&1 | tee -a /tmp/polybar2.log & disown
    ;;
esac

echo "Bars launched..."

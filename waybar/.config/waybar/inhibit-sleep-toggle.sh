#!/usr/bin/env bash
set -euo pipefail

FLAG="$XDG_CONFIG_HOME/hypr/sleep_inhibit.flag"

if [ -f "$FLAG" ]; then
    rm "$FLAG"
    notify-send "Sleep Inhibition" "Disabled "
else
    touch "$FLAG"
    notify-send "Sleep Inhibition" "Enabled "
fi

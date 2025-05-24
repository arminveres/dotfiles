#!/usr/bin/env bash
set -euo pipefail

FLAG="$XDG_CONFIG_HOME/hypr/sleep_inhibit.flag"

if [[ -f "$FLAG" ]]; then
	echo '{"text": ""}' # coffee icon (sleep not allowed)
else
	echo '{"text": ""}' # moon icon (sleep allowed)
	# return 0 for allowing concatenated commands to run
fi

#!/usr/bin/env bash
# Stand-in for hyprland/workspaces: Waybar 0.15 sends legacy dispatch syntax that
# Hyprland's Lua IPC rejects, so clicks did nothing. Usage: ws.sh <id> <label>
n=$1 label=$2

emit() {
  if [ "$(hyprctl activeworkspace -j | jq .id)" = "$n" ]; then
    printf '{"text":"%s","class":"active"}\n' "$label"
  elif hyprctl workspaces -j | jq -e ".[] | select(.id == $n)" >/dev/null; then
    printf '{"text":"%s"}\n' "$label"
  else
    echo '{"text":""}' # empty text hides the module, like hyprland/workspaces
  fi
}

emit
socat -u UNIX-CONNECT:"$XDG_RUNTIME_DIR/hypr/$HYPRLAND_INSTANCE_SIGNATURE/.socket2.sock" - |
  while read -r line; do
    case $line in
      workspace\>\>* | createworkspace\>\>* | destroyworkspace\>\>* | focusedmon\>\>*) emit ;;
    esac
  done

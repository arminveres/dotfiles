#!/usr/bin/env zsh
#
# Standalone setup (ssetup) of zsh config
#
setopt PIPE_FAIL ERR_EXIT NO_UNSET

export ZDOTDIR="${XDG_CONFIG_HOME:-$HOME/.config/}/zsh"

DRY_RUN=0
SCRIPT_SELF="$(realpath "$0")"
SCRIPT_PATH="${0:A:h}"

run() {
  if ((DRY_RUN)); then
    print -r -- "[dry-run] $*"
  else
    "$@"
  fi
}

# write_file <content> <destination>
write_file() {
  if ((DRY_RUN)); then
    print -r -- "[dry-run] write to $2:"
    print -r -- "$1"
  else
    printf "%s" "$1" >"$2"
  fi
}

main() {
  local arg
  for arg in "$@"; do
    case "$arg" in
    -n | --dry-run)
      DRY_RUN=1
      ;;
    -h | --help)
      printf "Usage: %s [-n|--dry-run]\n" "${0:t}"
      printf "  -n, --dry-run  Preview actions without making any changes\n"
      return 0
      ;;
    esac
  done

  if ((DRY_RUN)); then
    print -r -- "Dry run: no changes will be made"
  fi

  run mkdir --parents "$ZDOTDIR"

  write_file "export ${ZDOTDIR}
source ${ZDOTDIR}/env.zsh" "$HOME/.zshenv"
  write_file "source ${ZDOTDIR}/.zshenv" "$ZDOTDIR/.zshenv"
  write_file "source ${ZDOTDIR}/logout.zsh" "$ZDOTDIR/.zlogout"
  write_file "source ${ZDOTDIR}/profile.zsh" "$ZDOTDIR/.zprofile"
  write_file "source ${ZDOTDIR}/rc.zsh" "$ZDOTDIR/.zshrc"
  stow $([[ $DRY_RUN == 1 ]] && echo "--no") --verbose --target="$ZDOTDIR" --dir="$SCRIPT_PATH/.." zsh
}

main "$@"

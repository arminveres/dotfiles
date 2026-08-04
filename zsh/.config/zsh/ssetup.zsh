#!/usr/bin/env zsh
#
# Standalone setup (ssetup) of zsh config
#
setopt PIPE_FAIL ERR_EXIT NO_UNSET

export ZDOTDIR="${XDG_CONFIG_HOME:-$HOME/.config/}/zsh"

DRY_RUN=0
FORCE=0
SCRIPT_SELF="$(realpath "$0")"
SCRIPT_PATH="${0:A:h}"

run() {
  if ((DRY_RUN)); then
    print -r -- "[dry-run] $*"
  else
    "$@"
  fi
}

# clear_stow_conflicts <package_dir> <target_dir>
# Remove existing plain (non-symlink) files/dirs in <target_dir> that would
# conflict with stow, so stow can (re-)create its symlinks. Only entries that
# also exist in <package_dir> are considered.
clear_stow_conflicts() {
  local pkg_dir="$1" target_dir="$2"
  local entry name target_path

  for entry in "$pkg_dir"/*(ND) "$pkg_dir"/.*(ND); do
    name="${entry:t}"
    [[ "$name" == "." || "$name" == ".." ]] && continue
    target_path="$target_dir/$name"

    [[ -e "$target_path" || -L "$target_path" ]] || continue
    [[ -L "$target_path" ]] && continue

    if ((DRY_RUN)); then
      print -r -- "[dry-run] would remove conflicting file/dir: $target_path"
    else
      print -r -- "Removing conflicting file/dir: $target_path"
      rm -rf -- "$target_path"
    fi
  done
}

# write_file <content> <destination>
write_file() {
  local content="$1" dest="$2"

  if [[ -e "$dest" ]] && ! ((FORCE)); then
    if ((DRY_RUN)); then
      print -r -- "[dry-run] would skip existing file (use -f/--force to overwrite): $dest"
    else
      print -r -- "Skipping existing file (use -f/--force to overwrite): $dest"
    fi
    return 0
  fi

  if ((DRY_RUN)); then
    if [[ -e "$dest" ]]; then
      print -r -- "[dry-run] would overwrite $dest:"
    else
      print -r -- "[dry-run] write to $dest:"
    fi
    print -r -- $'\e[3m'"$content"$'\e[0m'
  else
    printf "%s" "$content" >"$dest"
  fi
}

main() {
  local arg
  for arg in "$@"; do
    case "$arg" in
    -n | --dry-run)
      DRY_RUN=1
      ;;
    -f | --force)
      FORCE=1
      ;;
    -h | --help)
      printf "Usage: %s [-n|--dry-run] [-f|--force]\n" "${0:t}"
      printf "  -n, --dry-run  Preview actions without making any changes\n"
      printf "  -f, --force    Overwrite already deployed files\n"
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
  # On Windows/MSYS (git-bash, MSYS2, Cygwin), stow's symlinks often don't
  # work without elevated privileges/developer mode, so use winstow instead:
  # https://github.com/MathiasCodes/winstow
  case "$(uname -s)" in
  MSYS* | MINGW* | CYGWIN*)
    local -a winstow_args
    winstow_args=(-v -t "$ZDOTDIR" -d "$SCRIPT_PATH/..")
    ((DRY_RUN)) && winstow_args+=(-n)
    ((FORCE)) && winstow_args+=(--override)
    winstow "${winstow_args[@]}" zsh
    ;;
  *)
    local -a stow_args
    stow_args=(--verbose --target="$ZDOTDIR" --dir="$SCRIPT_PATH/..")
    ((DRY_RUN)) && stow_args+=(--no)
    ((FORCE)) && clear_stow_conflicts "$SCRIPT_PATH" "$ZDOTDIR"
    stow "${stow_args[@]}" zsh
    ;;
  esac
}

main "$@"

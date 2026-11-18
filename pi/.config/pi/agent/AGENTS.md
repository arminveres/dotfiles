# Global guidelines

## File search tooling

- Search file contents with `rg` (ripgrep), never `grep`/`grep -r`.
- Find files by name with `fd`, never `find`, `ls -R` or shell globbing.
- Both respect `.gitignore` and `.ignore` by default; keep it that way.
  Only reach for `--no-ignore` / `--hidden` when an ignored file is explicitly the target, and say why.
- Use `rg`/`fd` only for your own local searching. In scripts, docs or other generated output, use standard tools (`grep`, `find`, etc.) unless told otherwise.

## Nix

- When `nix` is available, use it to get tools for local testing instead of installing globally, e.g. `nix-shell -p <pkg> --run '<cmd>'` or `nix run nixpkgs#<pkg>`.

## Publishing

- Never publish or push anything online without explicit prior permission. This covers `git push`, creating or forking remote repos, opening PRs or issues, uploading files, and publishing packages.
- Ask first and name the exact target (remote, repo, branch). Permission covers only that one action.

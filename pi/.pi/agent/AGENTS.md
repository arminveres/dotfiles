# Global guidelines

## File search tooling

- Search file contents with `rg` (ripgrep), never `grep`/`grep -r`.
- Find files by name with `fd`, never `find`, `ls -R` or shell globbing.
- Both respect `.gitignore` and `.ignore` by default; keep it that way. Only
  reach for `--no-ignore` / `--hidden` when an ignored file is explicitly the
  target, and say why.

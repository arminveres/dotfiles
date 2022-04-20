# dotconf-files

## Description

Handcrafted dotfiles for personal use, currently on Fedora Workstation 35.

| <!-- -->             | <!-- -->                                          |
| -------------------- | ------------------------------------------------- |
| Window Manager       | i3 (bspwm WIP)                                    |
| Status bar           | Polybar                                           |
| Shell                | zsh                                               |
| Editor               | NeoVIM                                            |
| Terminal Emulator    | kitty or Alacritty                                |
| Terminal Multiplexer | [TMUX](https://github.com/arminveres/tmux-config) |

## Usage

first run: \
Move or delete dotfiles which should be changed and then inside dotfiles do: \
`stow -vt ~ *`

Use following if you want to overwrite files in repo: \
`stow --adopt -vt ~ *`

## Dependencies

GNU stow, found either preinstalled or installable on all major distributions.

`# dnf install stow`

## TODO

- [ ] add script/function to correctly handle stowing

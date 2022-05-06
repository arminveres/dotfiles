# dotconf-files

## Description

Handcrafted dotfiles for personal use, currently on Fedora Workstation 35.

| Type                 | Currently in use                                  | Alternative |
| -------------------- | ------------------------------------------------- | ----------- |
| Window Manager       | i3                                                | bspwm       |
| Status bar           | Polybar                                           | <!-- -->    |
| Notifications        | dunst                                             |             |
| Shell                | zsh                                               | <!-- -->    |
| Editor               | NeoVIM                                            | <!-- -->    |
| Terminal Emulator    | kitty                                             | Alacritty   |
| Terminal Multiplexer | [TMUX](https://github.com/arminveres/tmux-config) | <!-- -->    |

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

- [ ] customize `dunst` notifications
- [ ] add script/function to correctly handle stowing
- [ ] make bspwm a full replacement (rofi powermenu)
- [ ] i3 add scratchpad switcher rofi
- [ ] customize dunst

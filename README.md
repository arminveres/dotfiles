# dotconf-files

![2022-08-29_20-17](https://user-images.githubusercontent.com/45210978/187270554-45283e6f-1880-4ac6-acb0-62151d07dc6b.png)

## Description

Handcrafted dotfiles for personal use, currently on Fedora Workstation 35.

| Type                 | Currently in use                                                                                  |
| -------------------- | ------------------------------------------------------------------------------------------------- |
| Window Manager       | AwesomeWM                                                                                         |
| Status bar           | Polybar                                                                                           |
| Notifications        | naughty, dunst                                                                                    |
| Shell                | zsh                                                                                               |
| Editor               | [NeoVIM](https://github.com/arminveres/dotconf-files/tree/home-fedora/dotfiles/nvim/.config/nvim) |
| Terminal Emulator    | kitty, alacritty                                                                                  |
| Terminal Multiplexer | [TMUX](https://github.com/arminveres/tmux-config)                                                 |

## Usage

first run: \
Move or delete dotfiles which should be changed and then inside dotfiles do: \
`$ stow -vt ~ *`

Use following if you want to overwrite files in repo: \
`$ stow --adopt -vt ~ *`

## Dependencies

GNU stow, found either preinstalled or installable on all major distributions.

`# dnf install stow`

## TODO

- Add secrets repo as submodule
- Add script/function to correctly handle stowing, e.g. [ansible](https://medium.com/espinola-designs/manage-your-dotfiles-with-ansible-6dbedd5532bb)
- Customize `dunst` notifications
- Clean up `git` history, i.e. squash the first ~ 200 commits
- Ansible
    - Add script to install `Colloid` GTK scheme
    - Add script for jonaburg picom

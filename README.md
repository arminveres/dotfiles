# dotfiles

![2022-11-17_11-30](https://user-images.githubusercontent.com/45210978/202423003-30c2ee47-930b-49ce-a7e4-abdc98cf4c5d.png)

## Description

Handcrafted dotfiles for personal use, currently on Fedora Workstation 37.

| Type                 | Currently in use                                                                                  |
| -------------------- | ------------------------------------------------------------------------------------------------- |
| Window Manager       | AwesomeWM                                                                                         |
| Notifications        | naughty, dunst                                                                                    |
| Shell                | zsh                                                                                               |
| Editor               | [NeoVIM](https://github.com/arminveres/nvim) |
| Terminal Emulator    | kitty, alacritty                                                                                  |
| Terminal Multiplexer | [TMUX](https://github.com/arminveres/tmux.conf)                                                   |

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
  - Add script to install `Colloid` GTK scheme
  - Add script for jonaburg picom

### nvim and zsh TODOs in respective folder

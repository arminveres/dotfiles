# dotfiles

> [!WARNING]
> The information below may be outdated, since I moved my system over to NixOS.
> I am also migrating some of the configs from there to Home-Manager, therefore, some of these
> options may even be unused.

![2024-01-02_12-42](https://github.com/arminveres/dotfiles/assets/45210978/77f283ba-20aa-442b-8685-b8fdb516d20f)

## Description

Handcrafted dotfiles for personal use, currently on Fedora Workstation 38.

| Type | Currently in use |
| -------------------- | ----------------------------------------------- |
| Distro | [NixOS](https://github.com/arminveres/nix-conf) |
| Window Manager | Hyprland (Wayland) |
| Notifications | SwayNC |
| Shell | zsh |
| Editor | [neovim](https://github.com/arminveres/nvim) |
| Terminal Emulator | alacritty, wezterm, ghostty, kitty |
| Terminal Multiplexer | [tmux](https://github.com/arminveres/tmux.conf) |

## Usage

First run:

Move or delete dotfiles which should be changed and then inside dotfiles do:

`$ stow -vt ~ *`

Use following if you want to overwrite files in repo:

`$ stow --adopt -vt ~ *`

## Dependencies

- GNU stow, found either pre-installed or installable on all major distributions.

`# dnf install stow`

- [fzf](https://github.com/junegunn/fzf), although it is already registered as a submodule under [the zsh plugins](./zsh/.config/zsh/plugins/fzf/).

- [ripgrep](https://github.com/BurntSushi/ripgrep)

- [fd](https://github.com/sharkdp/fd)

- [hyprland](https://wiki.hypr.land/)

### Nice to haves

- `autorandr` + `arandr` for managing multiple monitor layouts e.g., for laptops.

- `lazygit` or `gitui`

- `lazydocker`

- `solaar` for managing Logitech peripherals

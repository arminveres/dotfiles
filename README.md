# dotfiles

> **Warning**: Although I have not encountered any issues until now, the source code in this repo may
> not always be stable, even in the stable branch.

![2024-01-02_12-42](https://github.com/arminveres/dotfiles/assets/45210978/77f283ba-20aa-442b-8685-b8fdb516d20f)

## Description

Handcrafted dotfiles for personal use, currently on Fedora Workstation 38.

| Type                 | Currently in use                                |
| -------------------- | ----------------------------------------------- |
| Window Manager       | AwesomeWM (X11), Hyprland (Wayland)             |
| Notifications        | naughty, dunst                                  |
| Shell                | zsh                                             |
| Editor               | [neovim](https://github.com/arminveres/nvim)    |
| Terminal Emulator    | kitty, alacritty, wezterm                       |
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

- [fzf](https://github.com/junegunn/fzf), although it is already downloaded as a submodule under
  [the zsh plugins](./zsh/.config/zsh/plugins/fzf/).

- [ripgrep](https://github.com/BurntSushi/ripgrep): `$ cargo install ripgrep` or `# dnf install ripgrep`

- [fd](https://github.com/sharkdp/fd): `# dnf install fd-find` or `$ cargo install fd-find`

- hyprland: in addition to the [copr](https://copr.fedorainfracloud.org/coprs/solopasha/hyprland/)
  we also need to have [hyprsome](https://github.com/sopa0/hyprsome) installed, for AwesomeWM like
  workspace sets

### Nice to haves

- `autorandr` + `arandr` for managing multiple monitor layouts e.g. for the laptop

- `lazygit` or `gitui`

  - `# dnf copr enable atim/lazygit -y && dnf upgrade && dnf install lazygit`
  - `# dnf install gitui` or `$ cargo install gitui`

- `lazydocker`

  - `# dnf copr enable atim/lazydocker && dnf upgrade && dnf install lazydocker -y`

- Solaar for managing Logitech peripherals: `# dnf install solaar`

- I usually use cargo to manage some rust application therefore:

`$ curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh`

### Miscellaneous

- I am using GDM as login manager, therefore using `io.github.realmazharhussain.GdmSettings` to
  customize the login screen is quite nice, although it resets after every reboot and you can only
  set one background for any number of monitors. Therefore I am not using it anymore.

#### Laptop Power Usage

- use enhanced garbage collection on AwesomeWM
- remove tmux extra stuff, like memory and cpu collection

## TODO

### neovim

- [see](https://github.com/arminveres/nvim)

### awesome

- [see](./awesome/.config/awesome/README.md)

### Zsh

- [see](./zsh/.config/zsh/README.md)

### tmux

- [see](https://github.com/arminveres/tmux.conf)

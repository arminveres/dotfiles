# dotfiles

> **Warning**: Although I have not encountered any issues until now, the source code in this repo may
> not always be stable, even in the stable branch.

![2023-05-06_13-02](https://user-images.githubusercontent.com/45210978/236620337-46d11a9e-6e77-4816-ae22-03f9bc13bc32.png)

## Description

Handcrafted dotfiles for personal use, currently on Fedora Workstation 38.

| Type                 | Currently in use                                |
| -------------------- | ----------------------------------------------- |
| Window Manager       | AwesomeWM                                       |
| Notifications        | naughty                                         |
| Shell                | zsh                                             |
| Editor               | [NeoVIM](https://github.com/arminveres/nvim)    |
| Terminal Emulator    | kitty, alacritty, wezterm                       |
| Terminal Multiplexer | [TMUX](https://github.com/arminveres/tmux.conf) |

## Usage

first run: \
Move or delete dotfiles which should be changed and then inside dotfiles do: \
`$ stow -vt ~ *`

Use following if you want to overwrite files in repo: \
`$ stow --adopt -vt ~ *`

## Dependencies

- GNU stow, found either preinstalled or installable on all major distributions.

`# dnf install stow`

- [fzf](https://github.com/junegunn/fzf), although it is already downloaded as a submodule under [the zsh
  plugins](./zsh/.config/zsh/plugins/fzf/).

- [ripgrep](https://github.com/BurntSushi/ripgrep): `$ cargo install ripgrep` or `# dnf install ripgrep`

- [fd](https://github.com/sharkdp/fd): `# dnf install fd-find` or `$ cargo install fd-find`

### Nice to haves

- `autorandr` + `arandr` for managing multiple monitor layouts e.g. for the laptop

- `lazygit` or `gitui`

  - `# dnf copr enable atim/lazygit -y && dnf install lazygit`
  - `# dnf install gitui` or `$ cargo install gitui`

- Solaar for managing Logitech peripherals: `# dnf install solaar`

- I usually use cargo to manage some rust application therefore:

`$ curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh`

## TODO

### neovim

- [see](https://github.com/arminveres/nvim)

### awesome

- [see](./awesome/.config/awesome/README.md)

### zsh

- [see](./zsh/.config/zsh/README.md)

### tmux

- [see](https://github.com/arminveres/tmux.conf)

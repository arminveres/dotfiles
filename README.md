# dotfiles

![2022-11-17_11-30](https://user-images.githubusercontent.com/45210978/202423003-30c2ee47-930b-49ce-a7e4-abdc98cf4c5d.png)

## Description

Handcrafted dotfiles for personal use, currently on Fedora Workstation 37.

| Type                 | Currently in use                                |
| -------------------- | ----------------------------------------------- |
| Window Manager       | AwesomeWM                                       |
| Notifications        | naughty, dunst                                  |
| Shell                | zsh                                             |
| Editor               | [NeoVIM](https://github.com/arminveres/nvim)    |
| Terminal Emulator    | kitty, alacritty                                |
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

- [ripgrep](https://github.com/BurntSushi/ripgrep)

`$ cargo install ripgrep` or `# dnf install ripgrep`

- [fd](https://github.com/sharkdp/fd)

`# dnf install fd-find` or `$ cargo install fd-find`

- I usually use cargo to manage some rust application therefore:

`$ curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh`

### Nice to haves

- `autorandr` + `arandr` for managing multiple layouts e.g. for the laptop

- `lazygit` or `gitui`

  - `# dnf copr enable atim/lazygit -y && dnf install lazygit`
  - `# dnf install gitui` or `$ cargo install gitui`

- Solaar for managing Logitech peripherals

`# dnf install solaar`

## TODO

- Add secrets repo as submodule
- Add script/function to correctly handle stowing, e.g. [ansible](https://medium.com/espinola-designs/manage-your-dotfiles-with-ansible-6dbedd5532bb)
- Customize `dunst` notifications
- Clean up `git` history, i.e. squash the first ~ 200 commits
  - Add script to install `Colloid` GTK scheme
  - Add script for jonaburg picom

### nvim and zsh TODOs in respective folder

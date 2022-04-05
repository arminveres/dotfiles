#!/bin/env sh

# launch sudo session for shell
sudo --shell

# will be superfluous for fedora 36
# rpm fusion for ffmpeg
# dnf -y install https://download1.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm
# dnf -y install https://download1.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm

 # first install bare packages
dnf install -y \
    xorg-x11-server-Xorg \
    xorg-x11-xinit \
    xorg-x11-drv-* \
    mesa-dri-drivers\

# necessary packages
dnf install -y \
    abattis-cantarell-fonts \
    zip \
    unzip \
    sqlite \
    xrandr \
    xinput \
    xclip \
    git \
    gcc \
    g++ \
    clang \
    clang-tools-extra \
    stow \
    make \
    cmake \
    util-linux-user \
    unzip\
    wget \
    lm_sensors \
    flatpak \
    zsh

# window manager specifics
dnf install -y \
    feh \
    picom \
    rofi \
    ddccontrol \
    lxappearance \
    lxpolkit \
    trayer \
    pasystray \
    volumeicon \
    sxhkd \
    bspwm \
    polybar

# basic apps, mainly gui
dnf install -y \
    thunar \
    xarchiver \
    thunar-archive-plugin \
    kitty \
    firefox \
    htop \
    bpytop \
    speedtest-cli \
    playerctl \
    vlc \
    tldr

# ranger dependencies
dnf install -y \
    ranger \
    w3m

# neovim dependencies
dnf install -y \
    neovim \
    ruby \
    nodejs \
    golang \
    julia \
    ctags \
    pandoc

dnf install -y \
    oxygen-cursor-themes \
    papirus-icon-theme

# neomutt copr
# dnf copr enable flatcap/neomutt
# dnf install -y \
#     neomutt \
#     msmtp \
#     isync \
#     pass

# sioyek copr
dnf copr enable endle/sioyek
dnf install -y sioyek

# add flathub
flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo

# mkdir ~/gitfiles

# add rust toolchain with cargo
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh

cargo install \
    fd-find \
    rg \
    bat \
    exa \
    zoxide
    # alacritty

# install fzf
git clone --depth 1 https://github.com/junegunn/fzf.git ~/gitfiles/fzf
~/gitfiles/fzf/install

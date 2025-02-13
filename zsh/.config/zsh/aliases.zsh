# applications
alias vi="nvim"
alias viup="nvim --headless "+Lazy! sync" +qa"
alias vim="nvim"
alias py="python3"
alias pypip="pypy3 -m pip"
alias tmux="tmux -2"
alias jupnote="tmux new -s jupyter -d 'jupyter notebook'"

alias flup='flatpak update'
alias flean='flatpak remove --unused'

alias onefetch='onefetch --include-hidden'

# WARN: use single quotes
alias lg='pushd $(realpath .); lazygit; popd'
alias lad=lazydocker

# ================================================================================================
# aliasing coreutils
# ================================================================================================
# confirm before overwriting something
alias cp="cp -i"
alias mv="mv -i"
alias rma="rm -ir"
alias ln="ln -i"
alias mkdir="mkdir -pv"
alias df='df -h'     # human-readable sizes
alias free='free -m' # show sizes in MB
alias dd='dd status=progress'
alias cl=clear
alias mktempdir='cd $(mktemp -d)'
alias visudo='sudo visudo'

if command -v eza >/dev/null; then
    alias ls="eza --colour=always --group-directories-first --icons=always" # my preferred listing
    alias la="eza --colour=always --group-directories-first --long --all --header --icons=always"
    alias lag="eza --colour=always --group-directories-first --long --all --header --grid --icons=always"
    alias lsg="eza --colour=always --group-directories-first --long --header --grid --icons=always"
    alias ll="eza --colour=always --group-directories-first --long --header"
    alias tree="eza --colour=always --group-directories-first --tree --icons=always"
else
    alias ls="ls --color=always"
    alias la="ls --color=always --almost-all"
    alias ll="ls --color=always --long"
fi

if command -v bat >/dev/null; then
    alias cat="bat --style=plain"
fi

# ================================================================================================
# kb layout
# ================================================================================================
alias chkb="setxkbmap 'ch(de)'"
alias uskb="setxkbmap eu"

# restart resolve service, e.g. after Cisco VPN disconnect
alias restart_resolve="sudo systemctl restart systemd-resolved.service"

if command -v cargo >/dev/null; then
    alias carup="cargo install-update --all"
fi

# Terminal Specific Aliases
if [[ $TERM == "xterm-kitty" ]]; then
    alias connect="kitty +kitten ssh"
fi

if command -v hyprctl >/dev/null; then
    function resprg() {
        pkill $1
        hyprctl dispatch exec $1
    }
fi

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

alias lad=lazydocker
function lg() {
    pushd $(realpath .) >/dev/null
    lazygit
    popd >/dev/null
}

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
alias mktempdir='cd $(mktemp -d)'
alias visudo='sudo visudo'

if command -v eza >/dev/null; then
    local EZAOPTIONS="--colour=always --group-directories-first --icons=always"
    alias ls="eza $EZAOPTIONS" # my preferred listing
    alias la="eza $EZAOPTIONS --long --all --header"
    alias lag="eza $EZAOPTIONS --long --all --header --grid"
    alias lsg="eza $EZAOPTIONS --long --header --grid"
    alias ll="eza $EZAOPTIONS --long --header"
    alias tree="eza $EZAOPTIONS --tree"
else
    local LSOPTIONS="--color=always -H"
    alias ls="ls $LSOPTIONS"
    alias la="ls $LSOPTIONS --almost-all"
    alias ll="ls $LSOPTIONS -L"
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

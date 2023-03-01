alias mktempdir='cd $(mktemp -d)'
# applications
alias visudo='sudo visudo'

alias vi="nvim"
alias vim="nvim"
alias py="python3"
alias tmux="tmux -2"
alias jupnote="tmux new -s jupyter -d 'jupyter notebook'"

alias flup='flatpak update'
alias flean='flatpak remove --unused'

# exa
if [[ $(command -v exa) ]]; then
    alias ls="exa --color=always --group-directories-first --icons" # my preferred listing
    alias la="exa --color=always --group-directories-first --long --all --header --icons"
    alias lag="exa --color=always --group-directories-first --long --all --header --grid --icons"
    alias lg="exa --color=always --group-directories-first --long --header --grid --icons"
    alias ll="exa --color=always --group-directories-first --long --header"
    alias tree="exa --color=always --group-directories-first --tree --icons"
else
    alias ls="ls --color=always"
    alias la="ls --color=always --almost-all"
    alias ll="ls --color=always --long"
fi

# git
alias gb="git branch"
alias gls="git status"
alias ga="git add"
alias glo="git log --graph --oneline --decorate"
alias wt="git worktree"
alias gco="git checkout"
alias gsw="git switch"
# alias gsp="git submodule foreach git pull"

# aliasing coreutils
# confirm before overwriting something
alias cp="cp -i"
alias mv="mv -i"
# alias rm="rm -ir"
alias ln="ln -i"
alias mkdir="mkdir -pv"
alias df='df -h'     # human-readable sizes
alias free='free -m' # show sizes in MB
alias dd='dd status=progress'

# kb layout
alias chkb="setxkbmap 'ch(de)'"
alias uskb="setxkbmap us"

# restart resolve service, e.g. after Cisco VPN disconnect
alias restart_resolve="sudo systemctl restart systemd-resolved.service"

if [[ $(command -v cargo) ]]; then
    alias cargoup="cargo-install-update install-update --all"
fi

# Terminal Specific Aliases
if [[ $TERM == "xterm-kitty" ]]; then
  alias connect="kitty +kitten ssh"
fi

# linux workstation specific aliases, could move it into subdivided os specific aliases
case "$(uname -n)" in
    "") # Work specific aliases
    ;;
    *)
    ;;
esac

# Distro specifig aliases
case "$(lsb_release -i | awk '{print $3}')" in
    Ubuntu) # echo Ubuntu
        alias nala='sudo nala'
        alias upd='sudo apt update && sudo apt upgrade'
    ;;
    Fedora) # echo Fedora
        alias dnf='sudo dnf'
        alias din='dnf install'
        alias dup='dnf upgrade'
        alias doffup='dnf offline-upgrade download -y && dnf offline-upgrade reboot'
    ;;
    *)
    ;;
esac

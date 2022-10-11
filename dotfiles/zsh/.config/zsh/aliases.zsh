# applications
alias visudo='sudo visudo'

alias vi="nvim"
alias vim="nvim"
alias py="python3"
alias tmux="tmux -2"

# exa
alias ls="exa --color=always --group-directories-first --icons" # my preferred listing
alias la="exa --color=always --group-directories-first --long --all --header"
alias lag="exa --color=always --group-directories-first --long --all --header --grid --icons"
alias lg="exa --color=always --group-directories-first --long --header --grid --icons"
alias ll="exa --color=always --group-directories-first --long --header"

# git
alias g="git"
alias gb="git branch"
alias gls="git status"
alias ga="git add"
alias glo="git log --graph --oneline --decorate"
alias wt="git worktree"
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

# Terminal Specific Aliases
if [[ $TERM = "xterm-kitty" ]]
then
  alias ssh="kitty +kitten ssh"
fi

# linux workstation specific aliases, could move it into subdivided os specific aliases
case "$(uname -n)" in
    "avee-Workstation") # Work specific aliases
        alias qtc="~/Qt/Tools/QtCreator/bin/qtcreator -lastsession &"
        alias cube="/opt/st/stm32cubeide_1.8.0/stm32cubeide &"
        alias upd="sudo apt-get update && sudo apt-get upgrade -y"
        alias flatpak="sudo flatpak"
    ;;
    *)
    ;;
esac

case "$(lsb_release -i | awk '{print $3}')" in
    Ubuntu) # echo Ubuntu
        alias nala='sudo nala'
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

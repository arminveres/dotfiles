# configs
alias zconf="vi ~/.config/zsh/.zshrc"
alias i3conf="vi ~/.config/i3/config"
alias viconf="vi ~/.config/nvim/"

# applications
alias visudo='sudo visudo'

alias vi="nvim"
alias vim="nvim"

alias tmux="tmux -2"

alias la="exa -la --header"
alias lag="exa -la --header --grid --icons"
alias ll="exa -l --header"

alias btop="bpytop"

alias g="git"
alias gb="git branch"
alias gla="git status"
alias ga="git add"
alias glo="git log --graph --oneline --decorate"

# alias hisgr="history | rg" # replaced with fzf

alias mkdir="mkdir -pv"

# confirm before overwriting something
alias cp="cp -i"
alias mv="mv -i"
alias rm="rm -ir"
alias ln="ln -i"

# easier to read disk
alias df='df -h'     # human-readable sizes
alias free='free -m' # show sizes in MB

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
    Fedora) echo Fedora
        alias dnf='sudo dnf'
    ;;
    *) echo default
    ;;
esac


# OS Specific Aliases
case "$(uname -s)" in

Darwin)
    # echo 'Mac OS X'
    alias ls='ls -G'
    ;;

Linux)
    alias ls='ls --color=auto'
    alias restart_resolve="sudo systemctl restart systemd-resolved.service"
    ;;

CYGWIN* | MINGW32* | MSYS* | MINGW*)
    # echo 'MS Windows'
    ;;
*)
    # echo 'Other OS'
    ;;
    esac

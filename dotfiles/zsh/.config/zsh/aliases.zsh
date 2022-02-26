# configs
alias zconf="vi ~/.config/zsh/.zshrc"
alias i3conf="vi ~/.config/i3/config"
alias viconf="vi ~/.config/nvim/"

# applications
alias dnf='sudo dnf'
alias visudo='sudo visudo'

alias vi="nvim"
alias vim="nvim"

alias la="exa -la --header"
alias ll="exa -l --header"

alias btop="bpytop"

alias g="git"
alias gla="git status"
alias ga="git add"
alias glo="git log --graph --oneline --decorate"

# alias hisgr="history | rg"

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

# Work specific aliases
alias tmux="tmux -2"
alias croot="cd ~/voyager2"
# alias qtcreator="~/Qt/Tools/QtCreator/bin/qtcreator.sh &"
alias qtc="~/Qt/Tools/QtCreator/bin/qtcreator -lastsession &"
alias cube="/opt/st/stm32cubeide_1.8.0/stm32cubeide &"
alias upd="sudo apt-get update && sudo apt-get upgrade -y"

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

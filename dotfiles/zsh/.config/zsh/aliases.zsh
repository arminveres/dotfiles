alias zshconfig="vi ~/.zshrc"
alias i3conf="vi ~/.config/i3/config"
alias viconf="vi ~/.config/nvim/"

alias vi="nvim"
alias vim="nvim"

alias la="exa -la --header"
alias ll="exa -l --header"

alias btop="bpytop"

alias g="git"
alias gla="git status"
alias ga="git add"
alias glo="git log --graph --oneline"

alias hisgr="history | rg"

# confirm before overwriting something
alias cp="cp -i"
alias mv='mv -i'
alias rm='rm -i'

# easier to read disk
alias df='df -h'     # human-readable sizes
alias free='free -m' # show sizes in MB

# Terminal Specific Aliases
if [[ $TERM = "xterm-kitty" ]]
then
  alias ssh="kitty +kitten ssh"
fi

# OS Specific Aliases
case "$(uname -s)" in

Darwin)
	# echo 'Mac OS X'
	alias ls='ls -G'
	;;

Linux)
	alias ls='ls --color=auto'
	;;

CYGWIN* | MINGW32* | MSYS* | MINGW*)
	# echo 'MS Windows'
	;;
*)
	# echo 'Other OS'
	;;
esac

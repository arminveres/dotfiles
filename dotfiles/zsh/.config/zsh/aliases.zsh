alias zshconfig="vi ~/.zshrc"
alias ohmyzsh="vi ~/.oh-my-zsh"
alias i3conf="vi ~/.config/i3/config"
alias i3st="sudo vi /etc/i3status.conf"

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

if [[ $TERM = "xterm-kitty" ]]
then
  alias ssh="kitty +kitten ssh"
fi

# this enables the automatic sourcing of zshrc in the config dir, could also be put inot /etc/zsh/
export ZDOTDIR="$HOME/.config/zsh"

if command -v direnv >/dev/null; then
    eval "$(direnv hook zsh)"
fi

# WARN(aver): Zoxide removed this functionality and broke it for zsh.
if command -v zoxide >/dev/null; then
    eval "$(zoxide init zsh --cmd cd)"
fi

if command -v keychain >/dev/null; then
    eval "$(keychain --eval --agents ssh id_rsa gh)"
fi

# >>> mamba initialize >>>
# !! Contents within this block are managed by 'mamba init' !!
export MAMBA_EXE="$HOME/.local/bin/micromamba";
export MAMBA_ROOT_PREFIX="$HOME/micromamba";
__mamba_setup="$("$MAMBA_EXE" shell hook --shell zsh --prefix "$MAMBA_ROOT_PREFIX" 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__mamba_setup"
else
    if [ -f "$HOME/micromamba/etc/profile.d/micromamba.sh" ]; then
        . "$HOME/micromamba/etc/profile.d/micromamba.sh"
    else
        # export PATH="$HOME/micromamba/bin:$PATH"  # extra space after export prevents interference from conda init
        path+=("$HOME"/micromamba/bin)
    fi
fi
unset __mamba_setup
# <<< mamba initialize <<<
export PATH

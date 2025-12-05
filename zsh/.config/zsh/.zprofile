#
# Set fpath here to properly initialize with compinit
#

case "$(uname)" in
Linux)
    DISTRO=$(lsb_release -i | awk '{print $3}')
    export DISTRO
    ;;
Darwin)
    # export the distro for scrips and so to use
    path+=(/opt/arm-none-eabi-12/bin)
    eval "$(/opt/homebrew/bin/brew shellenv)"
    export LDFLAGS="-L/opt/homebrew/opt/libomp/lib"
    export CPPFLAGS="-I/opt/homebrew/opt/libomp/include"
    export VCPKG_ROOT="$HOME/vcpkg"
    if command -v brew >/dev/null; then
        # add brew completion
        fpath+=("$(brew --prefix)/share/zsh/site-functions")
    fi
    ;;
esac

# We need to set fpath here, because it gets loaded by /etc/zsh* very early
fpath+=(
    "$ZDOTDIR/plugins/zsh-completions/src"
    "$ZDOTDIR/completion"
)

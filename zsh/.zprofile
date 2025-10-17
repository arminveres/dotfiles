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
        FPATH="$(brew --prefix)/share/zsh/site-functions:${FPATH}"
    fi
    ;;
esac

# this enables the automatic sourcing of zshrc in the config dir, could also be put inot /etc/zsh/
export ZDOTDIR="$HOME/.config/zsh"

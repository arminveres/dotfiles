#
# Login shell setup. Runs after .zshenv, before .zshrc.
#

case "$(uname)" in
Darwin)
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

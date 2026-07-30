#!/usr/bin/env zsh
#
# Environment variables. Sourced from .zshenv, so this is available to every
# zsh invocation (interactive or not).

# XDG base directories, in case they are not already provided.
export XDG_CONFIG_HOME="${XDG_CONFIG_HOME:-$HOME/.config}"
export XDG_CACHE_HOME="${XDG_CACHE_HOME:-$HOME/.cache}"
export XDG_DATA_HOME="${XDG_DATA_HOME:-$HOME/.local/share}"
export XDG_STATE_HOME="${XDG_STATE_HOME:-$HOME/.local/state}"

# -------------------------------------------------------------------------------------------------
# XDG-ify applications that do not respect it by default
# -------------------------------------------------------------------------------------------------
export ERRFILE="$XDG_CACHE_HOME/X11/xsession-errors"
export WINEPREFIX="$XDG_DATA_HOME/wine"
export RUSTUP_HOME="$XDG_DATA_HOME/rustup"
export CARGO_HOME="$XDG_DATA_HOME/cargo"
export PSQL_HISTORY="$XDG_DATA_HOME/psql_history"
export PGPASSFILE="$XDG_CONFIG_HOME/pg/pgpass"
export PASSWORD_STORE_DIR="$XDG_DATA_HOME/pass"
export _JAVA_OPTIONS="-Djava.util.prefs.userRoot=$XDG_CONFIG_HOME/java"
export GRADLE_USER_HOME="$XDG_DATA_HOME/gradle"
export GNUPGHOME="$XDG_DATA_HOME/gnupg"
export GTK2_RC_FILES="$XDG_CONFIG_HOME/gtk-2.0/gtkrc"
export JDTLS_HOME="$XDG_DATA_HOME/nvim/lsp_servers/jdtls/"
export RIPGREP_CONFIG_PATH="$XDG_CONFIG_HOME/ripgrep/ripgreprc"
export MANGOHUD_CONFIGFILE="$XDG_CONFIG_HOME/MangoHud/MangoHud.conf"
export GOPATH="$XDG_DATA_HOME/go"
export JUPYTER_CONFIG_DIR="$XDG_CONFIG_HOME/jupyter"
export NETRC_FILE="$XDG_CONFIG_HOME/netrc"

# -------------------------------------------------------------------------------------------------
# Misc tooling
# -------------------------------------------------------------------------------------------------
export MINICOM="-con"
export NINJA_STATUS="[%f/%t %p, %oe/s, %es] "
export DOTNET_ROOT="$HOME/.dotnet"
export MANPAGER="nvim +Man!"
# always compile tex into a build directory
export VIMTEX_OUTPUT_DIRECTORY="build"

# Location where zsh dumps its completion cache (speeds up startup)
export ZSH_COMPLETION_DUMP="$XDG_CACHE_HOME/zsh/.zcompdump"

# Distribution id, used by distro.zsh. Read from /etc/os-release instead of
# shelling out to `lsb_release` (a python script, ~200ms) on every invocation.
if [[ -r /etc/os-release ]]; then
    DISTRO="${${(@M)${(f)"$(</etc/os-release)"}:#NAME=*}#NAME=}"
    DISTRO="${${DISTRO//\"/}%% *}"
    export DISTRO
fi

# -------------------------------------------------------------------------------------------------
# PATH
# -------------------------------------------------------------------------------------------------
path+=(
    /usr/local/bin
    /opt/gcc-arm-none-eabi/bin
    "$HOME"/bin
    "$HOME"/.bin
    "$HOME"/.local/bin
    "$GOPATH"/bin
    "$CARGO_HOME"/bin
    "$XDG_DATA_HOME"/bob/nvim-bin
    "$HOME"/.luarocks/bin
    "$DOTNET_ROOT"
    "$DOTNET_ROOT/tools"
)

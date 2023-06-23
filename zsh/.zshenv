export ERRFILE="$XDG_CACHE_HOME/X11/xsession-errors"

export VISUAL=nvim
export EDITOR=nvim

# setting some XDGs
export XDG_DATA_HOME=$HOME/.local/share
export XDG_CONFIG_HOME=$HOME/.config
export XDG_STATE_HOME=$HOME/.local/state
export XDG_CACHE_HOME=$HOME/.cache

export ZDOTDIR="$XDG_CONFIG_HOME/zsh"

export WINEPREFIX="$XDG_DATA_HOME"/wine
export RUSTUP_HOME="$XDG_DATA_HOME"/rustup
export CARGO_HOME="$XDG_DATA_HOME"/cargo
export PSQL_HISTORY="$XDG_DATA_HOME/psql_history"
export PGPASSFILE="$XDG_CONFIG_HOME/pg/pgpass"
export PASSWORD_STORE_DIR="$XDG_DATA_HOME"/pass
export _JAVA_OPTIONS=-Djava.util.prefs.userRoot="$XDG_CONFIG_HOME"/java
export GRADLE_USER_HOME="$XDG_DATA_HOME"/gradle
export GNUPGHOME="$XDG_DATA_HOME"/gnupg
export GTK2_RC_FILES="$XDG_CONFIG_HOME"/gtk-2.0/gtkrc
export JDTLS_HOME="$XDG_DATA_HOME/nvim/lsp_servers/jdtls/"
export RIPGREP_CONFIG_PATH=$XDG_CONFIG_HOME/ripgrep/ripgreprc
export MANGOHUD_CONFIGFILE=$XDG_CONFIG_HOME/MangoHud/MangoHud.conf
export GOPATH="$XDG_DATA_HOME"/go
export JUPYTER_CONFIG_DIR="$XDG_CONFIG_HOME"/jupyter
export _ZO_ECHO=1 # print dir before switching

# always compile tex in a build directory
export VIMTEX_OUTPUT_DIRECTORY=build

path+=("$HOME"/bin "$HOME"/.bin "$HOME"/.local/bin "$GOPATH"/bin "$CARGO_HOME"/bin /usr/local/bin \
    /opt/gcc-arm-none-eabi/bin "$XDG_DATA_HOME"/bob/nvim-bin)

export FZF_DEFAULT_COMMAND='rg --hidden -l ""'
export FZF_DEFAULT_OPTS='--height 40% --layout=reverse --border'

case "$(uname)" in
    Linux)
        export DISTRO=$(lsb_release -i | awk '{print $3}')
        ;;
    Darwin)
        # export the distro for scrips and so to use
        path+=(
            /opt/arm-none-eabi-12/bin
            # "$HOME"/Library/Python/3.11/bin
        )
        eval "$(/opt/homebrew/bin/brew shellenv)"
        ;;
esac

export PATH
# finally source the real zshrc
source "$ZDOTDIR"/.zshrc

export PATH=$HOME/bin:$HOME/.bin:$HOME/.local/bin:$HOME/go/bin:$CARGO_HOME/bin:/usr/local/bin:$PATH
export ZDOTDIR=$HOME/.config/zsh
ERRFILE="$XDG_CACHE_HOME/X11/xsession-errors"

export VISUAL=nvim
export EDITOR=nvim

# setting some XDGs
export XDG_DATA_HOME=$HOME/.local/share
export XDG_CONFIG_HOME=$HOME/.config
export XDG_STATE_HOME=$HOME/.local/state
export XDG_CACHE_HOME=$HOME/.cache

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
export JDTLS_HOME="/home/arminveres/.local/share/nvim/lsp_servers/jdtls/"
export RIPGREP_CONFIG_PATH=$HOME/.config/ripgrep/ripgreprc
export MANGOHUD_CONFIGFILE=$HOME/.config/MangoHud/MangoHud.conf

# finally source the real zshrc
source $ZDOTDIR/.zshrc

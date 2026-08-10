#!/usr/bin/env zsh
#
# Vendored plugins, checked out as git submodules under $ZDOTDIR/plugins.
# For more plugins: https://github.com/unixorn/awesome-zsh-plugins
#
# NOTE(aver): order matters, zsh-syntax-highlighting must be sourced last.

# On MSYS2/Cygwin, TERM is typically `cygwin`, which makes zvm_cursor_style fall
# into its default branch and evaluate `=~ '\e\][0-9]+;.+\a'`. That regex is
# rejected by the MSYS regex engine ("failed to compile regex: trailing
# backslash"). Pinning ZVM_TERM to an xterm-compatible value avoids that branch.
if [[ $OSTYPE == (msys|cygwin)* ]]; then
  ZVM_TERM=${ZVM_TERM:-xterm-256color}
fi
source "$ZDOTDIR/plugins/zsh-vi-mode/zsh-vi-mode.plugin.zsh"

# zvm_zle-line-finish runs after every command and always requests the
# USER_DEFAULT cursor, which makes zvm_cursor_style hit an `=~` regex
# (`'\e\][0-9]+;.+\a'`) that MSYS/Cygwin's regex engine can't compile
# ("failed to compile regex: trailing backslash"), regardless of $TERM.
# We don't set any *_MODE_CURSOR to a color escape sequence, so the OSC 112
# color-restore that regex guards is a no-op for us anyway; skip it.
# ponytail: drops OSC 112 cursor-color restore on MSYS/Cygwin; revisit if we
# ever set a *_MODE_CURSOR to a custom color escape sequence.
if [[ $OSTYPE == (msys|cygwin)* ]]; then
  function zvm_zle-line-finish() {
    zvm_set_cursor '\e[0 q'
    zvm_switch_keyword_history=()
  }
fi

source "$ZDOTDIR/plugins/git-prompt.zsh/git-prompt.zsh"
# autopair.zsh self-initializes at the end of the file, no autopair-init needed.
source "$ZDOTDIR/plugins/zsh-autopair/autopair.zsh"

source "$ZDOTDIR/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh"
source "$ZDOTDIR/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh"

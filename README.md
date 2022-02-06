# dotconf-files

first run: \
Move or delete dotfiles which should be changed and then do: \
stow -vt ~ dotfiles/*

Use following if you want to overwrite files in repo: \
stow --adopt -vt ~ dotfiles/*

TODO: add script/function to correctly handle stowing

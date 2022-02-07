# dotconf-files

first run: \
Move or delete dotfiles which should be changed and then inside dotfiles do: \
stow -vt ~ *

Use following if you want to overwrite files in repo: \
stow --adopt -vt ~ *

TODO: add script/function to correctly handle stowing

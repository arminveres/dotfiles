#!/bin/bash

SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"

cp $SCRIPT_DIR/i3conf ~/.config/i3/config
cp $SCRIPT_DIR ~/.zshrc

#!/bin/bash

SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"

cp ~/.config/i3/config $SCRIPT_DIR/i3conf
cp ~/.zshrc $SCRIPT_DIR

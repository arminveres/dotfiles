#!/bin/env bash

updates=$(dnf updateinfo -q --list | wc -l)

echo " $updates"

# if [ "$updates" -gt 0 ]; then
#     echo " $updates"
# else
#     echo ""
# fi

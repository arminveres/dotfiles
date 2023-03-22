#!/bin/sh

echo " dnf: $(dnf updateinfo -q --list 2> /dev/null | wc -l) / flat: $(flatpak update 2>/dev/null | tail -n +5 | head -2 | wc -l)"

# updates=$(dnf updateinfo -q --list 2> /dev/null| wc -l)

# updates="dnf: $(dnf updateinfo -q --list 2> /dev/null | wc -l) / flat: $(flatpak update 2>/dev/null | tail -n +5 | head -2 | wc -l)"
# echo " $updates"

# if [ "$updates" -gt 0 ]; then
#     echo " $updates"
# else
#     echo " 0"
# fi

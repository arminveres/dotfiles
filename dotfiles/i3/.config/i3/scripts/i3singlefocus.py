#!/bin/env python3
"""
This script moves a single window into the middle of the monitor with 400 size
horizontal gaps.
Optimized for an ultrawide monitor usage, less eyestrain.
Credits: Armin Veres
"""

from i3ipc import Connection, Event

i3 = Connection()


def set_gapped_focus(i3, event):
    focused = i3.get_tree().find_focused()
    ws = focused.workspace()
    output = ws.ipc_data["output"]
    no_wins = len(ws.leaves())
    if no_wins == 1 and output == "DisplayPort-1":  # only do it on my ultrawide
        event.container.command("gaps horizontal current set 400")
    else:
        event.container.command("gaps horizontal current set 0")


i3.on(Event.WINDOW_FOCUS, set_gapped_focus)
i3.main()

#!/usr/bin/env python

# Description: List all Qtile key bindings.
# Usage: `python qtile_kb.py`

from libqtile.command.client import InteractiveCommandClient
i = InteractiveCommandClient()
kb = i.display_kb()
for line in kb.split("\n"):
    print(line)

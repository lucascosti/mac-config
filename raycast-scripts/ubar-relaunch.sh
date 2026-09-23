#!/bin/bash

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title uBar relaunch
# @raycast.mode silent

# Optional parameters:
# @raycast.icon 🔁
# @raycast.packageName uBar

# Documentation:
# @raycast.author Lucas Costi

osascript -e 'quit app "Ubar"'

while pgrep -x "Ubar" > /dev/null; do
  sleep 0.2
done

open -a "Ubar"

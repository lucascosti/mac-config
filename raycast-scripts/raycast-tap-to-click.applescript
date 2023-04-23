#!/usr/bin/osascript

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Tap-to-click trackpad setting
# @raycast.mode silent

# Optional parameters:
# @raycast.icon tap-to-click.png
# @raycast.argument1 { "type": "text", "placeholder": "'on' / 'off' / blank", "optional": true }

# Documentation:
# @raycast.author Lucas Costi

on run argv

set tap_to_set to ""

if (count of argv) > 0 then
  set arg1 to item 1 of argv
  if arg1 is in {"on", "off"} then
      set tap_to_set to arg1
  else
      set tap_to_set to "toggle"
  end if
else
  set tap_to_set to "toggle"
end if

tell application "System Settings"
  activate
  delay 1
end tell

open location "x-apple.systempreferences:com.apple.Trackpad-Settings.extension"

tell application "System Events" to tell its application process "System Settings"
  repeat until window "Trackpad" exists
  end repeat
  
  set trackpad_checkbox to checkbox 2 of group 1 of scroll area 1 of group 1 of group 2 of splitter group 1 of group 1 of window "Trackpad" of application process "System Settings" of application "System Events"

  if tap_to_set is "on" then
      if value of trackpad_checkbox is not 1 then
      click trackpad_checkbox
      else 
        log "Tap to click is already on 🙃"
      end if
  else if tap_to_set is "off" then
      if value of trackpad_checkbox is 1 then 
        click trackpad_checkbox
      else
        log "Tap to click is already off 🙃"
      end if  
  else if tap_to_set is "toggle" then
      click trackpad_checkbox
  end if

end tell

delay 1
tell application "System Settings"
  quit
end tell

end run
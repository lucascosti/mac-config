# mac-config
Some of the miscellaneous configuration files I use on my work MacBook.

This repo contains the following config files:

* [Karabiner key mapping configuration](karabiner/)

  I have a lot of muscle memory from using Windows and Linux OSs and keyboards, and this makes it a lot easier.
  
  Generally, I have my `Ctrl` key function as the MacOS `Cmd` key. However, when using the built-in MacBook keyboard, I also use Karabiner to swap the `Ctrl` and `fn` keys (so the bottom left key is the main modifier key).
  
  In addition to the above Karabiner settings, I have the following configured in the MacOS internal keyboard preferences for the modifier keys:
  
  ![Keyboard settings](keyboardsettings.png)
* [MacOS key bindings for text navigation](macoskeybindings/macoskeybindings.md)
  
  In addition to the above Karabiner settings to change keys, I also have changed some of the default MacOS keybindings to make keyboard text navigation behave more like Windows.
  
  This includes changing the behaviour of the `Home` and `End` keys to respectively move the cursor to the beginning and end of a line (and using `Shift` to select the text if desired).
  
  Also, I have swapped the `Cmd/Alt+Arrow` keys behaviour: `Cmd+Left/RightArrow` now moves the cursor between words, and `Alt+Left/RightArrow` moves to the start/end of a line (and `Shift` with both sets to select the text, if desired). 
  
  This seems to work everywhere in MacOS, except some text editors, like Atom. Atom has it's own keymap, so I have also had to replicate this behaviour in the Atom keymap settings. 
* [iTerm2 configuration](iterm2/)
  
  Especially for the colour palette that I really got used to when using Fedora.
* For my `.bashrc` configuration, see [its own specific repo](https://github.com/lucascosti/bashrc).

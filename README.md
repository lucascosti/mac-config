# mac-config

The main configuration files I use for my work MacBook.

This repo contains the following config files:
* [Zsh shell configuration](zsh/)

  See its [own README for details](zsh/).
* [Karabiner key mapping configuration](karabiner/)

  I have a lot of muscle memory from using Windows and Linux OSs and keyboards, and this makes it a lot easier.
  
  Although I previously remapped some of the modifier keys using the native MacOS Preferences interface, I now have implemented almost everything in my [Karabiner](https://pqrs.org/osx/karabiner/) configuration.

  * On my **Windows keyboard**, I have the modifier keys (<kbd>Ctrl</kbd>&nbsp;<kbd>⊞ Win</kbd>&nbsp;<kbd>Alt</kbd>) remapped as the following:
    
    | Physical keyboard key | Mapped to MacOS... |
    | -----------|------------ |
    | <kbd>Ctrl</kbd> | <kbd>⌘ Command</kbd> |
    | <kbd>⊞ Win</kbd> | <kbd>⌥ Option</kbd> |
    | <kbd>Alt</kbd> | <kbd>^ Control</kbd> |
    
  * On the **built-in MacBook keyboard**, I have the modifier keys (<kbd>fn</kbd>&nbsp;<kbd>^ Control</kbd>&nbsp;<kbd>⌥ Option</kbd>&nbsp;<kbd>⌘ Command</kbd>) remapped as the following:
    
    | Physical keyboard key | Mapped to MacOS... |
    | -----------|------------ |
    | <kbd>fn</kbd> | <kbd>⌘ Command</kbd> |
    | <kbd>^ Control</kbd> | <kbd>fn</kbd> |
    | <kbd>⌥ Option</kbd> | <kbd>⌥ Option</kbd> |
    | <kbd>⌘ Command</kbd> | <kbd>^ Control</kbd> |
    
  I also have a few key extra combination shortcuts that do special things. For example, <kbd>⌥ Option(mapped)</kbd>+<kbd>Tab</kbd> opens MacOS Mission Control, and a single press on <kbd>⌥ Option(mapped)</kbd> is mapped to the keyboard shortcut to open [Alfred](https://www.alfredapp.com/).
  
  This [`karabiner/`](karabiner/) directory is symlinked from `~/.config/karabiner`.
  
* [MacOS key bindings for text navigation](macoskeybindings/DefaultKeyBinding.dict)
  
  In addition to the above Karabiner settings to change keys, I also have changed some of the default MacOS keybindings to make keyboard text navigation behave more like Windows.
  
  This includes changing the behaviour of the <kbd>Home</kbd> and <kbd>End</kbd> keys to respectively move the cursor to the beginning and end of a line (and using <kbd>Shift</kbd> to select the text if desired).
  
  Also, I have swapped the <kbd>⌘ Command</kbd>/<kbd>⌥ Option</kbd>+<kbd> arrow</kbd> keys behaviour: <kbd>⌘ Command(mapped)</kbd>+<kbd>←</kbd>/<kbd>→</kbd>  now moves the cursor between words, and <kbd>⌥ Option(mapped)</kbd>+<kbd>←</kbd>/<kbd>→</kbd> moves to the start/end of a line (and <kbd>Shift</kbd> with both sets to select the text, if desired). 
  
  This seems to work everywhere in MacOS, except some text editors, like Atom. Atom has its own keymap, so I have also had to replicate this behaviour in the Atom keymap settings.

  Place this file in the `~/Library/KeyBindings` folder (you might need to create that folder).
  
  Inspiration from: https://damieng.com/blog/2015/04/24/make-home-end-keys-behave-like-windows-on-mac-os-x
* [iTerm2 configuration](iterm2/)
  
  Especially for the colour palette that I really got used to when using Fedora, as well as some key mappings (as iTerm2 doesn't recognise/respect most [custom `DefaultKeyBinding.dict`](macoskeybindings/DefaultKeyBinding.dict) settings).
  
  Set the iTerm configuration to this file in **iTerm2 > Preferences > General > Preferences > Load preferences from a custom folder or URL**
* [VS Code configuration](vscode/)
  
  The files that control the majority of my VS Code editor's configuration.
  
  These files/folders are symlinked from `~/Library/Application Support/Code/User/`
  
  To get a list of extensions, I used this command: `code --list-extensions > vs_code_extensions_list.txt`

* [Firefox](firefox/)
  
  Mainly just [`userChrome.css`](firefox/userChrome.css), this configures some minor (mainly font) changes in the Firefox UI, aka the 'chrome'. The user profile location on macOS is `~/Library/Application Support/Firefox/Profiles/xxxxxxxx.default`.
  
  See https://www.reddit.com/r/FirefoxCSS/ for some good tutorials and required settings for have a custom `userChrome.css`. 
* Some other minor settings:
  * I use [uBar](https://brawersoftware.com/products/ubar) as a Windows-like taskbar, so I have the MacOS Dock set to autohide on the right of the screen. This command sets the Dock to be less sensitive to appear, so it's less prone to accidental activation when I move the cursor near the right edge of the screen.
    
    ```shell
    defaults write com.apple.dock autohide-delay -float 0.20
    killall Dock
    ```


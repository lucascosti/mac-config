# Lucas' Zsh config

This is my Zsh configuration. Feel free to clone/copy and reuse.

The main files that do the work are:

* [`.zshrc`](.zshrc): Main settings file. It contains oh-my-zsh settings, and also my custom functions and git aliases.
* [`zshscripts/themes/oh-my-posh-lucas.omp.json`](zshscripts/themes/oh-my-posh-lucas.omp.json): My custom [Oh My Posh](https://ohmyposh.dev/) theme file.

  Oh My Posh is a prompt customisation tool that allows you to do show fancy things on the prompt. On macOS, you must first [install it using brew](https://ohmyposh.dev/docs/installation/macos). Oh My Posh and the theme file are loaded from `.zshrc`.

I use the following [git submodules](https://git-scm.com/book/en/v2/Git-Tools-Submodules), which are stored in [`zshscripts/`](zshscripts/):

* [zsh-syntax-highlighting](https://github.com/zsh-users/zsh-syntax-highlighting) to enable syntax highlighting for the commands I enter at the prompt.
* [zsh-autosuggestions](https://github.com/zsh-users/zsh-autosuggestions) to enable autosuggestions after the prompt.
* [cheat/cheatsheets](https://github.com/cheat/cheatsheets) for use with the [`cheat` command](https://github.com/cheat/cheat). The cheat command was installed using brew, but the cheatsheets are stored here. (See also the [cheat config file](zshscripts/miscdotfiles/cheat/conf.yml).)

<img src="https://raw.githubusercontent.com/lucascosti/mac-config/main/zsh/git-prompt.png" width="50%">

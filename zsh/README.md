# Lucas' Zsh config

This is my Zsh configuration. Feel free to clone/copy and reuse.

In August 2019, I migrated my work MacBook over to use [Zsh](https://en.wikipedia.org/wiki/Z_shell) (with [oh-my-zsh](https://ohmyz.sh/)) as my default shell. This configuration aims to mirror and enhance [my previous bash configuration](https://github.com/lucascosti/bashrc).

The main files that do the work are:

* [`.zshrc`](.zshrc): Main settings file. It contains oh-my-zsh settings, and also my custom functions and git aliases.
* [`zshscripts/themes/p10k-lucas.zsh`](zshscripts/themes/p10k-lucas.zsh): My custom powerlevel10k theme file. Powerlevel10k and this theme file are sourced in `.zshrc`. This theme uses glyphs that require a [Nerd Fonts-patched font](https://github.com/ryanoasis/nerd-fonts) in your terminal.

I use the following [git submodules](https://git-scm.com/book/en/v2/Git-Tools-Submodules), which are stored in [`zshscripts/`](zshscripts/):

* [Powerlevel10k](https://github.com/romkatv/powerlevel10k) (which is a faster implementation of [powerlevel9k](https://github.com/Powerlevel9k/powerlevel9k)) to customise the look of the prompt.
* [zsh-syntax-highlighting](https://github.com/zsh-users/zsh-syntax-highlighting) to enable syntax highlighting for the command I enter at the prompt.
* [cheat/cheatsheets](https://github.com/cheat/cheatsheets) for use with the [`cheat` command](https://github.com/cheat/cheat). The cheat command was installed using brew, but the cheatsheets are stored here. (See also the [cheat config file](zshscripts/miscdotfiles/cheat/conf.yml).)

<img src="https://raw.githubusercontent.com/lucascosti/zshrc/master/git-prompt.png" width="50%">

**Note:** This config was previously hosted in its [own repository](https://github.com/lucascosti/zshrc), before it was moved here in April 2020.

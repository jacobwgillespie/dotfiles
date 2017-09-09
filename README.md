# opinionated dotfiles

Dotfiles customize your system - these are mine.  [Fork](https://github.com/jacobwg/dotfiles/fork) this repository and make it your own!

## components

There's a few special files in the hierarchy.

- **bin/**: Anything in `bin/` will get added to your `$PATH` and be made available everywhere.
- **Brewfile**: This is a list of applications for [Homebrew Cask](https://caskroom.github.io) to install: things like Chrome and 1Password and Adium and stuff. Might want to edit this file before running any initial setup.
- **topic/\*.zsh**: Any files ending in `.zsh` get loaded into your environment.
- **topic/path.zsh**: Any file named `path.zsh` is loaded first and is
  expected to setup `$PATH` or similar.
- **topic/completion.zsh**: Any file named `completion.zsh` is loaded
  last and is expected to setup autocomplete.
- **topic/\*.symlink**: Any files ending in `*.symlink` get symlinked into your `$HOME`. This is so you can keep all of those versioned in your dotfiles but still keep those autoloaded files in your home directory. These get symlinked in when you run `script/bootstrap`.

## install

``` bash
$ git clone https://github.com/jacobwg/dotfiles.git ~/.dotfiles
$ cd ~/.dotfiles
$ script/bootstrap
```

This will symlink the appropriate files in `.dotfiles` to your home directory. Everything is configured and tweaked within `~/.dotfiles`.

The main file you'll want to change right off the bat is `zsh/zshrc.symlink`, which sets up a few paths that'll be different on your particular machine.

`dot` is a simple script that installs some dependencies, sets sane macOS defaults, and so on. Tweak this script, and occasionally run `dot` from time to time to keep your environment fresh and up-to-date.  You can find this script in `bin/`.

## bugs

I want this to work for everyone; that means when you clone it down it should work for you even though you may not have `rbenv` installed, for example. That said, I do use this as *my* dotfiles, so there's a good chance I may break something if I forget to make a check for a dependency.

If you're brand-new to the project and run into any blockers, please [open an issue](https://github.com/jacobwg/dotfiles/issues) on this repository and I'd love to get it fixed for you!

## thanks

I actively watch the following repositories and add the best changes to this repository:

* [holman/dotfiles](https://github.com/holman/dotfiles)
* [ryanb/dotfiles](https://github.com/ryanb/dotfiles)
* [mathiasbynes/dotfiles](https://github.com/mathiasbynens/dotfiles)

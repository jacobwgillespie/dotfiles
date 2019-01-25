# dotfiles

Dotfiles for configuring macOS or Linux with ZSH and Homebrew.

## Requirements

- macOS or Linux
- ZSH (on macOS, the install script will install ZSH via Homebrew)
- Homebrew (on macOS, the install script will install Homebrew)

## Installation

```bash
$ git clone https://github.com/jacobwgillespie/dotfiles.git ~/.dotfiles
$ cd ~/.dotfiles
$ ./setup
```

This will install all required dotfiles in your home directory as symlinks. Everything is then configured via modifying files in `~/.dotfiles`.

## Software

The `Brewfile` installs most all of the software and applications I have installed on my Mac. I typically also install:

- App Store
  - Lungo
  - Microsoft Office 365
  - Pixelmator
  - Reeder
  - Things
  - Tweetbot
  - Xcode

## Structure

The repository is organized as follows:

- `setup` - setup script that can be used to install or update the dotfiles on your system
- `Brewfile` - a list of software to install via Homebrew
- `bin/*` - any executable scripts in this directory are added to your `$PATH`
- `config/*.zsh` - configuration files for ZSH, they are all sourced automatically into any new shell
- `functions/*` - zsh functions and autocomplete completion definitions
- `symlinks/*` - any files ending in `*.symlink` get symlinked into your home directory, with an added dot and missing the suffix (e.g. `gitignore.symlink` becomes `~/.gitignore`) - automatically symlinked via the `./setup` script

## License

MIT License. See `LICENSE`.

## Inspiration

The following repositories served as inspiration for this repository:

- [holman/dotfiles](https://github.com/holman/dotfiles)
- [ryanb/dotfiles](https://github.com/ryanb/dotfiles)
- [mathiasbynes/dotfiles](https://github.com/mathiasbynens/dotfiles)

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

The `Brewfile` installs all of the software and applications I have installed on my Mac, including Homebrew formulae, Homebrew casks, and Mac App Store applications.

## Structure

The repository is organized as follows:

- `setup` - setup script that can be used to install or update the dotfiles on your system
- `Brewfile` - a list of software to install via Homebrew (see `brew bundle` and `brew bundle cleanup`)
- `bin/*` - any executable scripts in this directory are added to your `$PATH`
- `config/*.zsh` - configuration files for ZSH, they are all sourced automatically into any new shell
- `functions/*` - zsh functions and autocomplete completion definitions
- `symlinks/*` - any files ending in `*.symlink` get symlinked by the `./setup` script into your home directory with the suffix removed (e.g. `gitignore.symlink` becomes `~/.gitignore`)

## License

MIT License. See `LICENSE`.

## Inspiration

The following repositories served as inspiration for this repository:

- [holman/dotfiles](https://github.com/holman/dotfiles)
- [ryanb/dotfiles](https://github.com/ryanb/dotfiles)
- [mathiasbynes/dotfiles](https://github.com/mathiasbynens/dotfiles)

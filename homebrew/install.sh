#!/bin/sh
#
# Homebrew
#
# This installs some of the common dependencies needed (or at least desired)
# using Homebrew.

# Check for Homebrew
if test ! $(which brew)
then
  echo "  Installing Homebrew for you."
  ruby -e "$(curl -fsSL https://raw.github.com/Homebrew/homebrew/go/install)" > /tmp/homebrew-install.log
fi

# Install homebrew packages
brew bundle $ZSH/homebrew/Brewfile

# TODO: do this if not already done
# add zsh as a shell
#sudo echo "/usr/local/bin/zsh" >> /etc/shells
#sudo chsh -s /usr/local/bin/zsh `whoami`
#
#Echo "Done!"

exit 0

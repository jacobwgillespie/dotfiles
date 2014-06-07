#!/bin/sh

# Install homebrew-cask
brew tap caskroom/cask
brew tap caskroom/versions
brew tap caskroom/fonts
brew tap caskroom/unofficial
brew install brew-cask

# Install from Caskfile
brew bundle $ZSH/homebrew-cask/Caskfile

# Make alfred work with cask
brew cask alfred link

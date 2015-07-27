# Sets reasonable OS X defaults
#
# Run ./set-defaults.sh and you'll be good to go

# Disable press-and-hold for keys in favor of key repeat
defaults write -g ApplePressAndHoldEnabled -bool false

# Always open everything in Finder's list view
defaults write com.apple.Finder FXPreferredViewStyle Nlsv

# Show the ~/Library folder
chflags nohidden ~/Library

# Set a really fast key repeat
defaults write NSGlobalDomain KeyRepeat -int 0

# Set the Finder prefs for showing a few different volumes on the Desktop
defaults write com.apple.finder ShowExternalHardDrivesOnDesktop -bool false
defaults write com.apple.finder ShowRemovableMediaOnDesktop -bool false

# Put the display to sleep if we're in the bottom-left hot corner
defaults write com.apple.dock wvous-bl-corner -int 10
defaults write com.apple.dock wvous-bl-modifier -int 0

# Never go into computer sleep mode
sudo systemsetup -setcomputersleep Off > /dev/null

# Disable the sound effects on boot
sudo nvram SystemAudioVolume=" "

# Set the icon size of Dock items to 36 pixels
defaults write com.apple.dock tilesize -int 36

# Reset Launchpad
find ~/Library/Application\ Support/Dock -name "*.db" -maxdepth 1 -delete

# Require password immediately after sleep or screen saver begins
defaults write com.apple.screensaver askForPassword -int 1
defaults write com.apple.screensaver askForPasswordDelay -int 0

# Disable smart quotes and dashes as they’re annoying when typing code
defaults write NSGlobalDomain NSAutomaticQuoteSubstitutionEnabled -bool false
defaults write NSGlobalDomain NSAutomaticDashSubstitutionEnabled -bool false
defaults write com.apple.messageshelper.MessageController SOInputLineSettings -dict-add "automaticQuoteSubstitutionEnabled" -bool false

# Disable automatic emoji substitution in messages (i.e. use plain text smileys)
defaults write com.apple.messageshelper.MessageController SOInputLineSettings -dict-add "automaticEmojiSubstitutionEnablediMessage" -bool false

# Trackpad: enable tap to click for this user and for the login screen
defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad Clicking -bool true
defaults -currentHost write NSGlobalDomain com.apple.mouse.tapBehavior -int 1
defaults write NSGlobalDomain com.apple.mouse.tapBehavior -int 1

# Trackpad: map bottom right corner to right-click
defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad TrackpadCornerSecondaryClick -int 2
defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad TrackpadRightClick -bool true
defaults -currentHost write NSGlobalDomain com.apple.trackpad.trackpadCornerClickBehavior -int 1
defaults -currentHost write NSGlobalDomain com.apple.trackpad.enableSecondaryClick -bool true

# Don’t display the annoying prompt when quitting iTerm
defaults write com.googlecode.iterm2 PromptOnQuit -bool false

# Start SizeUp at login
defaults write com.irradiatedsoftware.SizeUp StartAtLogin -bool true

# Don’t show the SizeUp preferences window on next start
defaults write com.irradiatedsoftware.SizeUp ShowPrefsOnNextStart -bool false

# Disable screenshot shadows (they're HUGE!)
defaults write com.apple.screencapture disable-shadow -bool true

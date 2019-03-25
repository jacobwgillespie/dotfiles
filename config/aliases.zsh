# Reload zsh configuration
alias reload!='. ~/.zshrc'

# Restart Jitouch
alias jitouch="(pkill Jitouch || true) && open /Library/PreferencePanes/Jitouch.prefPane/Contents/Resources/Jitouch.app"

# Speedtest
alias speedtest="wget --output-document=/dev/null http://speedtest.dal01.softlayer.com/downloads/test500.zip"

# Clear and reset the screen
alias clr="tput reset"

# Enable aliases to be sudo’ed
alias sudo='sudo '

# Flush DNS cache
alias flush="sudo killall -HUP mDNSResponder"

# Remove duplicates in the "Open With" menu
alias lscleanup="/System/Library/Frameworks/CoreServices.framework/Frameworks/LaunchServices.framework/Support/lsregister -kill -r -domain local -domain system -domain user && killall Finder"

# Canonical hex dump; some systems have this symlinked
command -v hd > /dev/null || alias hd="hexdump -C"

# OS X has no `md5sum`, so use `md5` as a fallback
command -v md5sum > /dev/null || alias md5sum="md5"

# OS X has no `sha1sum`, so use `shasum` as a fallback
command -v sha1sum > /dev/null || alias sha1sum="shasum"

# Recursively delete `.DS_Store` files
alias cleanup="find . -type f -name '*.DS_Store' -ls -delete"

# Show/hide hidden files in Finder
alias show="defaults write com.apple.finder AppleShowAllFiles -bool true && killall Finder"
alias hide="defaults write com.apple.finder AppleShowAllFiles -bool false && killall Finder"

# Enable/disable Spotlight
alias spoton="sudo mdutil -a -i on"
alias spotoff="sudo mdutil -a -i off"

# Load .env file
function loadenv() { cat .env | while read a; do export $a; done }

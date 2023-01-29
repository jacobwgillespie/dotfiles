# Clear and reset the screen
if [[ "$TERM_PROGRAM" == "iTerm.app" ]]; then
  alias clr="echo '\u001b]1337;ClearScrollback\u0007'"
else
  alias clr="tput reset"
fi

# Restart audio service to fix issues
alias fix-audio="sudo pkill coreaudiod; sudo pkill -9 bluetoothaudiod"

# Flush DNS cache
alias flush="sudo killall -HUP mDNSResponder"

# Remove duplicates in the "Open With" menu
alias lscleanup="/System/Library/Frameworks/CoreServices.framework/Frameworks/LaunchServices.framework/Support/lsregister -kill -r -domain local -domain system -domain user && killall Finder"

# Canonical hex dump; some systems have this symlinked
command -v hd > /dev/null || alias hd="hexdump -C"

# Recursively delete `.DS_Store` files
alias cleanup="find . -type f -name '*.DS_Store' -ls -delete"

# Show/hide hidden files in Finder
alias show="defaults write com.apple.finder AppleShowAllFiles -bool true && killall Finder"
alias hide="defaults write com.apple.finder AppleShowAllFiles -bool false && killall Finder"

# Enable/disable Spotlight
alias spot-on="sudo mdutil -a -i on"
alias spot-off="sudo mdutil -a -i off"

# Fun!
alias tada="open -g raycast://confetti"

# Load .env file
function loadenv() { cat .env | grep -v '^#' | grep -v '^$' | while read a; do export $a; done }

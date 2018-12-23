alias reload!='. ~/.zshrc'

# Speedtest
alias speedtest="wget --output-document=/dev/null http://speedtest.wdc01.softlayer.com/downloads/test500.zip"

# Enable aliases to be sudo’ed
alias sudo='sudo '

# Enhanced WHOIS lookups
#alias whois="whois -h whois-servers.net"

# Flush Directory Service cache
# Necessary to kill mDNSResponder in OS X 10.7 and 10.8 (see http://support.apple.com/kb/HT5343)
# TODO: drop OS X 10.6 support?
alias flush="dscacheutil -flushcache && sudo killall -HUP mDNSResponder"

# Clean up LaunchServices to remove duplicates in the “Open With” menu
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

# Hide/show all desktop icons (useful when presenting)
alias hidedesktop="defaults write com.apple.finder CreateDesktop -bool false && killall Finder"
alias showdesktop="defaults write com.apple.finder CreateDesktop -bool true && killall Finder"

# Disable Spotlight
alias spotoff="sudo mdutil -a -i off"
# Enable Spotlight
alias spoton="sudo mdutil -a -i on"

function loadenv() { cat .env | while read a; do export $a; done }

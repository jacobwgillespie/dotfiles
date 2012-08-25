# Remove the hosts that I don't want to keep around- in this case, only
# keep the first host. Like a boss.
alias hosts="head -2 ~/.ssh/known_hosts | tail -1 > ~/.ssh/known_hosts"

# Pipe my public key to my clipboard.
alias pubkey="more ~/.ssh/id_dsa.pub | pbcopy | echo '=> Public key copied to pasteboard.'"

# Generate pubkey
# TODO: make this into a proper script, asking for email
alias genpubkey="ssh-keygen -t dsa -C 'mail@jacobwg.com'"
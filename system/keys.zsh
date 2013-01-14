# Pipe my public key to my clipboard.
alias pubkey="more ~/.ssh/id_dsa.pub | pbcopy | echo '=> Public key copied to pasteboard.'"

# Generate pubkey
# TODO: make this into a proper script, asking for email
alias genpubkey="ssh-keygen -t dsa -C 'mail@jacobwg.com'"
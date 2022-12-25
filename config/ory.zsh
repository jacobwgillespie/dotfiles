if (( $+commands[ory] )); then
  source <(ory completion zsh)
  compdef _ory ory
fi

if (( $+commands[flyctl] )); then
  eval "$(flyctl completion zsh)"
  compdef _flyctl fly
fi

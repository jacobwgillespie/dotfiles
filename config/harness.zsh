# This is a private CLI, you can ignore this file
if (( $+commands[harness] )); then
  source <(harness completion zsh)
  alias h=harness
  compdef h=harness
fi

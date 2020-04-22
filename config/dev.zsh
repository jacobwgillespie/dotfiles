# This is a private CLI, you can ignore this file
if (( $+commands[dev] )); then
  source <(dev completion script)
  alias d=dev
  compdef d=dev
fi

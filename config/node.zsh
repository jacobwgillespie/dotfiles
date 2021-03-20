if (( $+commands[yarn] )); then
  export PATH="$(yarn global bin 2>/dev/null):$PATH"
fi

export N_PREFIX="$HOME/.n"
export PATH="$N_PREFIX/bin:$PATH"

# This is a private CLI, you can ignore this file
if (( $+commands[dev] )); then
  source <(dev completion script)
  alias d=dev
  compdef d=dev
fi

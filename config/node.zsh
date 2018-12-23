export N_PREFIX="$HOME/.n"
export PATH="$N_PREFIX/bin:$PATH"

if (( $+commands[yarn] )); then
  export PATH="$(yarn global bin 2>/dev/null):$PATH"
fi

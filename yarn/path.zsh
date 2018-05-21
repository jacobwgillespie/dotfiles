if (( $+commands[yarn] )); then
  local YARN_BIN="$(yarn global bin 2>/dev/null)"
  export PATH="$YARN_BIN:$PATH"
fi

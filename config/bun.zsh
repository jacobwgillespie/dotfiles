if (( $+commands[bun] )); then
  alias run="bun run"
  compdef run=bun
fi

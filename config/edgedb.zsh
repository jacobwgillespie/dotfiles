if (( $+commands[edgedb] )); then
  source <(edgedb _gen_completions --shell=zsh 2>/dev/null | sed 's/_edgedb "$@"//')
  compdef _edgedb edgedb
fi

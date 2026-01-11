if (( $+commands[opencode] )); then
  export OPENCODE_ENABLE_EXA=true
  eval "$(opencode completion)"
fi

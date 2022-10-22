if (( $+commands[nomad] )); then
  autoload -U +X bashcompinit && bashcompinit
  complete -o nospace -C nomad nomad
fi

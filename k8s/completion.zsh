if (( $+commands[kubectl] ))
then
  alias k=kubectl
  compdef k=kubectl
fi

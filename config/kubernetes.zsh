# Setup kubectl alias
if (( $+commands[kubectl] ))
then
  alias k=kubectl
fi

# Setup stern autocompletion
if (( $+commands[stern] ))
then
  source <(stern --completion=zsh)
fi

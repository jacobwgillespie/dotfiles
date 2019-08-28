# Setup kubectl alias
if (( $+commands[kubectl] )); then
  alias k=kubectl
fi

# Setup stern autocompletion
if (( $+commands[stern] )); then
  source <(stern --completion=zsh)
fi

# Setup kubectx alias
if (( $+commands[kubectx] )); then
  alias kc=kubectx
fi

# Setup kubens alias
if (( $+commands[kubens] )); then
  alias kn=kubens
fi

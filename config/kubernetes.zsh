# Setup kubectl alias
if (( $+commands[kubectl] )); then
  source <(kubectl completion zsh 2>/dev/null)
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

export USE_GKE_GCLOUD_AUTH_PLUGIN=True

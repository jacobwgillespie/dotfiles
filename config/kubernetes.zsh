# Setup kubectl alias
if (( $+commands[kubectl] )); then
  source <(kubectl completion zsh 2>/dev/null)
  alias k=kubectl
  complete -o default -F __start_kubectl k
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

# Include krew plugins
if [[ -d ~/.krew/bin ]]; then
  export PATH="$PATH:$HOME/.krew/bin"
fi

export KUBE_EDITOR="code -w"

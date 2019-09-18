# Expose variables to iTerm2 (for statusbar integration)
function iterm2_print_user_vars() {
  # Kubernetes context
  if (( $+commands[kubectl] )); then
    iterm2_set_user_var kubecontext $(kubectl config current-context 2>/dev/null)
    iterm2_set_user_var kubenamespace $(kubectl config view --minify --output 'jsonpath={..namespace}' 2>/dev/null)
  fi

  # Node version
  if (( $+commands[node] )); then
    node_version=$(node -v 2>/dev/null)
    [[ $node_version == "" ]] || iterm2_set_user_var node_version "$node_version"
  fi
}

if [ -e ~/.iterm2_shell_integration.zsh ]; then
  source ~/.iterm2_shell_integration.zsh
fi

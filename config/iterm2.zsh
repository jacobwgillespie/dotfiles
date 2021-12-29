# Expose variables to iTerm2 (for statusbar integration)
function iterm2_print_user_vars() {
  # Execute in the background to display next prompt faster
  ( _async_iterm2_print_user_vars & ) 2>/dev/null
}

function _async_iterm2_print_user_vars() {
  # Kubernetes context
  if (( $+commands[kubectl] )); then
    local kubecontext="$(kubectl config current-context 2>/dev/null)"
    if [[ "$kubecontext" != "" ]]; then
      kubecontext="⎈ $kubecontext"
    fi
    iterm2_set_user_var kubecontext $kubecontext
    iterm2_set_user_var kubenamespace $(kubectl config view --minify --output 'jsonpath={..namespace}' 2>/dev/null)
  fi

  # Node version
  if (( $+commands[node] )); then
    node_version=$(node -e 'console.log(process.version.slice(1))' 2>/dev/null)
    [[ $node_version == "" ]] || iterm2_set_user_var node_version "Node $node_version"
  fi

  # Rust version
  if (( $+commands[rustc] )); then
    rust_version=$(rustc --version 2>/dev/null | head -n1 | cut -d' ' -f2)
    [[ $rust_version == "" ]] || iterm2_set_user_var rust_version "Rust $rust_version"
  fi

  # Terraform version
  if (( $+commands[terraform] )); then
    terraform_version=$(terraform --version 2>/dev/null | head -n1 | cut -d' ' -f2 | cut -d'v' -f2)
    [[ $terraform_version == "" ]] || iterm2_set_user_var terraform_version "Terraform $terraform_version"
  fi

  # Go version
  if (( $+commands[go] )); then
    go_version=$(go version | cut -d' ' -f3 | sed 's/go//')
    [[ $go_version == "" ]] || iterm2_set_user_var go_version "Go $go_version"
  fi

  # Disable custom rprompt
  export RPROMPT=""
}

if [ -e "$DOTFILES/config/iterm/shell-integration.zsh" ]; then
  source "$DOTFILES/config/iterm/shell-integration.zsh"
fi

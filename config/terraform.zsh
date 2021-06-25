if (( $+commands[terraform] )); then
  export TF_PLUGIN_CACHE_DIR="$HOME/.terraform.d/plugin-cache"
  mkdir -p "$TF_PLUGIN_CACHE_DIR"
  alias t="terraform"
fi

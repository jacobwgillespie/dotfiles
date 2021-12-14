# Set window title
set_window_title() {
  print -n '\e]0;'

  # Show hostname if connected through SSH
  [[ -n $SSH_CONNECTION ]] && print -Pn '(%m) '

  # Show last three directory components
  print -Pn '%3~'

  print -n '\a'
}
precmd_functions+=(set_window_title)

# Read prompt config from ~/.dotfiles
export STARSHIP_CONFIG="$DOTFILES/config/starship/config.toml"

# Prevent percentage showing up if output doesn't end with a newline.
export PROMPT_EOL_MARK=''

# Configure prompt
if (( $+commands[starship] )); then
  eval "$(starship init zsh)"
fi

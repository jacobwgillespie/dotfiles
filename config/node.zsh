if (( $+commands[pnpm] )); then
  export PNPM_HOME="/Users/jacobwgillespie/Library/pnpm"
  export PATH="$PNPM_HOME:$PATH"
fi

if (( $+commands[yarn] )); then
  export PATH="$(yarn global bin 2>/dev/null):$PATH"
fi

export N_PREFIX="$HOME/.n"
export PATH="$N_PREFIX/bin:$PATH"
export NPM_CONFIG_FUND=false

# This is a private CLI, you can ignore this
if (( $+commands[dev] )); then
  source <(dev completion script)
  alias d=dev
  compdef d=dev
fi

# Integrate with modules using tabtab
if [[ -f ~/.config/tabtab/zsh/__tabtab.zsh ]]; then
  source ~/.config/tabtab/zsh/__tabtab.zsh || true
fi

if (( $+commands[github-copilot-cli] )); then
  eval "$(github-copilot-cli alias -- "$0")"
fi

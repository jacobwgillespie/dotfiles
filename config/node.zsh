if (( $+commands[pnpm] )); then
  export PNPM_HOME="/Users/jacobwgillespie/Library/pnpm"
  export PATH="$PNPM_HOME:$PATH"
fi

export N_PREFIX="$HOME/.n"
export PATH="$N_PREFIX/bin:$PATH"
export NPM_CONFIG_FUND=false

# Integrate with modules using tabtab
if [[ -f ~/.config/tabtab/zsh/__tabtab.zsh ]]; then
  source ~/.config/tabtab/zsh/__tabtab.zsh || true
fi

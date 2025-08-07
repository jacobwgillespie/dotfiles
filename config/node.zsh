if (( $+commands[pnpm] )); then
  export PNPM_HOME="/Users/jacobwgillespie/Library/pnpm"
  export PATH="$PNPM_HOME:$PATH"
fi

export NPM_CONFIG_FUND=false

# Integrate with modules using tabtab
if [[ -f ~/.config/tabtab/zsh/__tabtab.zsh ]]; then
  source ~/.config/tabtab/zsh/__tabtab.zsh || true
fi

# Returns an error when executing pnpm in a directory containing another package manager's lockfile
function pnpm() {
  if [ -f bun.lock ]; then
    echo "Detected $(tput bold)bun.lock$(tput sgr0), did you mean $(tput bold)bun$(tput sgr0)?" 1>&2
    return 1
  fi

  if [ -f yarn.lock ]; then
    echo "Detected $(tput bold)yarn.lock$(tput sgr0), did you mean $(tput bold)yarn$(tput sgr0)?" 1>&2
    return 1
  fi

  if [ -f package-lock.json ]; then
    echo "Detected $(tput bold)package-lock.json$(tput sgr0), did you mean $(tput bold)npm$(tput sgr0)?" 1>&2
    return 1
  fi

  command pnpm "$@"
}

# Returns an error when executing yarn in a directory containing another package manager's lockfile
function yarn() {
  if [ -f bun.lock ]; then
    echo "Detected $(tput bold)bun.lock$(tput sgr0), did you mean $(tput bold)bun$(tput sgr0)?" 1>&2
    return 1
  fi

  if [ -f pnpm-lock.yaml ]; then
    echo "Detected $(tput bold)pnpm-lock.yaml$(tput sgr0), did you mean $(tput bold)pnpm$(tput sgr0)?" 1>&2
    return 1
  fi

  if [ -f package-lock.json ]; then
    echo "Detected $(tput bold)package-lock.json$(tput sgr0), did you mean $(tput bold)npm$(tput sgr0)?" 1>&2
    return 1
  fi

  command yarn "$@"
}

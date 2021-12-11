if [ -f $HOMEBREW_PREFIX/etc/bash_completion.d/az ]; then
  autoload -U +X bashcompinit && bashcompinit
  source $HOMEBREW_PREFIX/etc/bash_completion.d/az
fi

if [ -f /usr/local/etc/bash_completion.d/az ]; then
  autoload -U +X bashcompinit && bashcompinit
  source /usr/local/etc/bash_completion.d/az
fi

# Colorize common tools with grc
if (( $+commands[grc] )) && (( $+commands[brew] )); then
  source $HOMEBREW_PREFIX/etc/grc.zsh

  # Remove docker, as it breaks interactive mode
  unset -f docker
fi

# Override ls with eza or gls, add colors
if (( $+commands[eza] )); then
  alias ls="eza -F"
  alias l="eza -la"
  alias ll="eza -l"
  alias tree="eza -TF"
elif (( $+commands[gls] )); then
  alias ls="gls -F --color"
  alias l="gls -lAh --color"
  alias ll="gls -l --color"
else
  alias ls="ls -F"
  alias l="ls -lAh"
  alias ll="ls -l"
fi

# Override cat with bat
if (( $+commands[bat] )); then
  alias cat=bat
  export BAT_STYLE=plain # only enable syntax highlighting
  export BAT_THEME="ansi"
fi

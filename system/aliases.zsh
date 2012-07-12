# grc overides for ls
#   Made possible through contributions from generous benefactors like
#   `brew install coreutils`
if $(gls &>/dev/null)
then
  alias l="gls --color -lAh"
  alias ll="gls --color -l"
  alias la='gls --color -A'
  alias ls="gls --color"
else
  alias l="ls --color -lAh"
  alias ll="ls --color -l"
  alias la='ls --color -A'
  alias ls="ls --color"
fi
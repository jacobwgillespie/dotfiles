# grc overides for ls
#   Made possible through contributions from generous benefactors like
#   `brew install coreutils`
if $(gls &>/dev/null)
then
  alias ls="gls --color"
fi

alias l="ls -lAh"
alias ll="ls -l"
alias la='ls -A'
alias ls="ls -F"
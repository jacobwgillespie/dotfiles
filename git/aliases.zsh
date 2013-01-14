# Use `hub` as our git wrapper:
#   http://defunkt.github.com/hub/
hub_path=$(which hub)
if (( $+commands[hub] ))
then
  alias git=$hub_path
fi

alias ga='git add'
alias gl='git pull --prune'
alias gp='git push origin HEAD'
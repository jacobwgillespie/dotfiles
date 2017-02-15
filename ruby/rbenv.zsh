# init according to man page
if (( $+commands[rbenv] ))
then
  eval "$(rbenv init -)"
else
  if [ -d "$HOME/.rbenv/bin" ]; then
    export PATH="$HOME/.rbenv/bin:$PATH"
    eval "$(rbenv init -)"
  fi
fi

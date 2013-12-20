# Now using ruby-2.0.0-p353
#alias r='rbenv local 2.0.0-p353'

alias migrate='rake db:migrate db:test:clone'

spring_path=$(which spring)
if (( $+commands[spring] ))
then
  alias r="$spring_path rails"
fi

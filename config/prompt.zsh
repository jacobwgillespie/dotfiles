# Mostly taken from https://github.com/denysdovhan/spaceship-zsh-theme/blob/master/spaceship.zsh

prompt_set_title() {
  # emacs terminal does not support settings the title
  (( ${+EMACS} )) && return

  # tell the terminal we are setting the title
  print -n '\e]0;'
  # show hostname if connected through ssh
  [[ -n $SSH_CONNECTION ]] && print -Pn '(%m) '
  case $1 in
    expand-prompt)
      print -Pn $2;;
    ignore-escape)
      print -rn $2;;
  esac
  # end set title
  print -n '\a'
}

prompt_precmd() {
  prompt_set_title 'expand-prompt' '%~'
}

prompt_preexec() {
}

present() {
  if [ -z "$PROMPT_PRESENTATION_MODE" ]; then
    export PROMPT_PRESENTATION_MODE=1
  else
    unset PROMPT_PRESENTATION_MODE
  fi
}

setup() {
  # Disable python virtualenv environment prompt prefix
  export VIRTUAL_ENV_DISABLE_PROMPT=true

  # Prevent percentage showing up if output doesn't end with a newline.
  export PROMPT_EOL_MARK=''

  # Load zsh modules
  autoload -Uz add-zsh-hook

  # Add zsh hooks
  add-zsh-hook precmd prompt_precmd
  add-zsh-hook preexec prompt_preexec

  # Configure prompt
  eval "$(prompt init zsh)"

  # LSCOLORS
  # Online editor: https://geoff.greer.fm/lscolors/
  export LSCOLORS="Gxfxcxdxbxegedabagacab"
  export LS_COLORS='no=00:fi=00:di=01;34:ln=00;36:pi=40;33:so=01;35:do=01;35:bd=40;33;01:cd=40;33;01:or=41;33;01:ex=00;32:ow=0;41:*.cmd=00;32:*.exe=01;32:*.com=01;32:*.bat=01;32:*.btm=01;32:*.dll=01;32:*.tar=00;31:*.tbz=00;31:*.tgz=00;31:*.rpm=00;31:*.deb=00;31:*.arj=00;31:*.taz=00;31:*.lzh=00;31:*.lzma=00;31:*.zip=00;31:*.zoo=00;31:*.z=00;31:*.Z=00;31:*.gz=00;31:*.bz2=00;31:*.tb2=00;31:*.tz2=00;31:*.tbz2=00;31:*.avi=01;35:*.bmp=01;35:*.fli=01;35:*.gif=01;35:*.jpg=01;35:*.jpeg=01;35:*.mng=01;35:*.mov=01;35:*.mpg=01;35:*.pcx=01;35:*.pbm=01;35:*.pgm=01;35:*.png=01;35:*.ppm=01;35:*.tga=01;35:*.tif=01;35:*.xbm=01;35:*.xpm=01;35:*.dl=01;35:*.gl=01;35:*.wmv=01;35:*.aiff=00;32:*.au=00;32:*.mid=00;32:*.mp3=00;32:*.ogg=00;32:*.voc=00;32:*.wav=00;32:*.patch=00;34:*.o=00;32:*.so=01;35:*.ko=01;31:*.la=00;33'
  # Zsh to use the same colors as ls
  # Link: http://superuser.com/a/707567
  zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}
}

setup "$@"

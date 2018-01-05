# Mostly taken from https://github.com/denysdovhan/spaceship-zsh-theme/blob/master/spaceship.zsh

# Check if command exists in $PATH
# USAGE:
#   _exists <command>
_exists() {
  command -v $1 > /dev/null 2>&1
}

# Check if the current directory is in a Git repository.
# USAGE:
#   _is_git
_is_git() {
  command git rev-parse --is-inside-work-tree &>/dev/null
}

# Outputs the name of the current branch
# Usage example: git pull origin $(git_current_branch)
# Using '--quiet' with 'symbolic-ref' will not cause a fatal error (128) if
# it's not a symbolic ref, but in a Git repo.
git_current_branch() {
  local ref
  ref=$(command git symbolic-ref --quiet HEAD 2> /dev/null)
  local ret=$?
  if [[ $ret != 0 ]]; then
    [[ $ret == 128 ]] && return  # no git repo.
    ref=$(command git rev-parse --short HEAD 2> /dev/null) || return
  fi
  echo ${ref#refs/heads/}
}

# Get the status of the working tree
git_prompt_status() {
  local INDEX STATUS
  INDEX=$(command git status --porcelain -b 2> /dev/null)
  STATUS=""
  if $(echo "$INDEX" | command grep -E '^\?\? ' &> /dev/null); then
    STATUS="$ZSH_THEME_GIT_PROMPT_UNTRACKED$STATUS"
  fi
  if $(echo "$INDEX" | grep '^A  ' &> /dev/null); then
    STATUS="$ZSH_THEME_GIT_PROMPT_ADDED$STATUS"
  elif $(echo "$INDEX" | grep '^M  ' &> /dev/null); then
    STATUS="$ZSH_THEME_GIT_PROMPT_ADDED$STATUS"
  fi
  if $(echo "$INDEX" | grep '^ M ' &> /dev/null); then
    STATUS="$ZSH_THEME_GIT_PROMPT_MODIFIED$STATUS"
  elif $(echo "$INDEX" | grep '^AM ' &> /dev/null); then
    STATUS="$ZSH_THEME_GIT_PROMPT_MODIFIED$STATUS"
  elif $(echo "$INDEX" | grep '^ T ' &> /dev/null); then
    STATUS="$ZSH_THEME_GIT_PROMPT_MODIFIED$STATUS"
  fi
  if $(echo "$INDEX" | grep '^R  ' &> /dev/null); then
    STATUS="$ZSH_THEME_GIT_PROMPT_RENAMED$STATUS"
  fi
  if $(echo "$INDEX" | grep '^ D ' &> /dev/null); then
    STATUS="$ZSH_THEME_GIT_PROMPT_DELETED$STATUS"
  elif $(echo "$INDEX" | grep '^D  ' &> /dev/null); then
    STATUS="$ZSH_THEME_GIT_PROMPT_DELETED$STATUS"
  elif $(echo "$INDEX" | grep '^AD ' &> /dev/null); then
    STATUS="$ZSH_THEME_GIT_PROMPT_DELETED$STATUS"
  fi
  if $(command git rev-parse --verify refs/stash >/dev/null 2>&1); then
    STATUS="$ZSH_THEME_GIT_PROMPT_STASHED$STATUS"
  fi
  if $(echo "$INDEX" | grep '^UU ' &> /dev/null); then
    STATUS="$ZSH_THEME_GIT_PROMPT_UNMERGED$STATUS"
  fi
  if $(echo "$INDEX" | grep '^## [^ ]\+ .*ahead' &> /dev/null); then
    STATUS="$ZSH_THEME_GIT_PROMPT_AHEAD$STATUS"
  fi
  if $(echo "$INDEX" | grep '^## [^ ]\+ .*behind' &> /dev/null); then
    STATUS="$ZSH_THEME_GIT_PROMPT_BEHIND$STATUS"
  fi
  if $(echo "$INDEX" | grep '^## [^ ]\+ .*diverged' &> /dev/null); then
    STATUS="$ZSH_THEME_GIT_PROMPT_DIVERGED$STATUS"
  fi
  echo $STATUS
}

# Draw prompt section (bold is used as default)
# USAGE:
#   _prompt_section <color> [prefix] <content> [suffix]
PROMPT_OPENED=false # Internal variable for checking if prompt is opened
_prompt_section() {
  local color prefix content suffix
  [[ -n $1 ]] && color="%F{$1}"  || color="%f"
  [[ -n $2 ]] && prefix="$2"     || prefix=""
  [[ -n $3 ]] && content="$3"    || content=""
  [[ -n $4 ]] && suffix="$4"     || suffix=""

  [[ -z $3 && -z $4 ]] && content=$2 prefix=''

  echo -n "%{%B%}" # set bold
  if [[ $PROMPT_OPENED == true ]]; then
    echo -n "$prefix"
  fi
  PROMPT_OPENED=true
  echo -n "%{%b%}" # unset bold

  echo -n "%{%B$color%}" # set color
  echo -n "$content"     # section content
  echo -n "%{%b%f%}"     # unset color

  echo -n "%{%B%}" # reset bold, if it was diabled before
  echo -n "$suffix"
  echo -n "%{%b%}" # unset bold
}

# USER
# If user is root, then paint it in red. Otherwise, just print in yellow.
prompt_user() {
  # [[ $SPACESHIP_USER_SHOW == false ]] && return

  if [[ $LOGNAME != $USER ]] || [[ $UID == 0 ]] || [[ -n $SSH_CONNECTION ]]; then
    local user_color

    if [[ $USER == 'root' ]]; then
      user_color="red"
    else
      user_color="yellow"
    fi

    _prompt_section \
      "$user_color" \
      "with " \
      '%n' \
      " "
  fi
}

# HOST
# If there is an ssh connections, current machine name.
prompt_host() {
  [[ -n $SSH_CONNECTION ]] || return

  _prompt_section \
    "green" \
    "at " \
    '%m' \
    " "
}

# DIR
# Current directory. Return only three last items of path
prompt_dir() {
  _prompt_section \
    "blue" \
    "in " \
    "%3~" \
    " "
}

# GIT COLOR
# The color of the git branch name, based on the current status
prompt_git_color() {
  _is_git || return

  local INDEX
  INDEX=$(command git status --porcelain 2> /dev/null)

  if [ -z "$INDEX" ]; then
    echo "green"
  else
    echo "magenta"
  fi
}

# GIT BRANCH
# Show current git brunch using git_current_status from Oh-My-Zsh
prompt_git_branch() {
  _is_git || return

  local git_color="$(prompt_git_color)"

  _prompt_section \
    "$git_color" \
    " $(git_current_branch)"
}

# GIT STATUS
# Check if current dir is a git repo, set up ZSH_THEME_* variables
# and show git status using git_prompt_status from Oh-My-Zsh
# Reference:
#   https://github.com/robbyrussell/oh-my-zsh/blob/master/lib/git.zsh
prompt_git_status() {
  _is_git || return

  ZSH_THEME_GIT_PROMPT_UNTRACKED="?"
  ZSH_THEME_GIT_PROMPT_ADDED="+"
  ZSH_THEME_GIT_PROMPT_MODIFIED="!"
  ZSH_THEME_GIT_PROMPT_RENAMED="»"
  ZSH_THEME_GIT_PROMPT_DELETED="✘"
  ZSH_THEME_GIT_PROMPT_STASHED="$"
  ZSH_THEME_GIT_PROMPT_UNMERGED="="
  ZSH_THEME_GIT_PROMPT_AHEAD="⇡"
  ZSH_THEME_GIT_PROMPT_BEHIND="⇣"
  ZSH_THEME_GIT_PROMPT_DIVERGED="⇕"

  local git_status="$(git_prompt_status)"

  if [[ -n $git_status ]]; then
    # Status prefixes are colorized
    _prompt_section \
      "red" \
      " $git_status"
  fi
}

# GIT
# Show both git branch and git status:
#   prompt_git_branch
#   prompt_git_status
prompt_git() {
  local git_branch="$(prompt_git_branch)" git_status="$(prompt_git_status)"

  [[ -z $git_branch ]] && return

  _prompt_section \
    'white' \
    "on " \
    "${git_branch}${git_status}" \
    " "
}

# NODE
# Show current version of node, exception system.
prompt_node() {
  # Show NODE status only for JS-specific folders
  [[ -f package.json || -d node_modules || -n *.js(#qN^/) ]] || return

  local node_version

  if _exists nvm; then
    node_version=$(nvm current 2>/dev/null)
    [[ $node_version == "system" || $node_version == "node" ]] && return
  elif _exists nodenv; then
    node_version=$(nodenv version-name)
    [[ $node_version == "system" || $node_version == "node" ]] && return
  elif _exists node; then
    node_version=$(node -v 2>/dev/null)
    [[ $node_version == "" ]] && return
  else
    return
  fi

  echo -n "%{%B%F{green}%}"
  echo -n "⬢ $node_version"
  echo -n "%{%b%f%}"
}

# RUBY
# Show current version of Ruby
prompt_ruby() {
  # Show versions only for Ruby-specific folders
  [[ -f Gemfile || -f Rakefile || -n *.rb(#qN^/) ]] || return

  local ruby_version

  if _exists rvm-prompt; then
    ruby_version=$(rvm-prompt i v g)
  elif _exists chruby; then
    ruby_version=$(chruby | sed -n -e 's/ \* //p')
  elif _exists rbenv; then
    ruby_version=$(rbenv version-name)
  else
    return
  fi

  [[ "${ruby_version}" == "system" ]] && return

  # Add 'v' before ruby version that starts with a number
  [[ "${ruby_version}" =~ ^[0-9].+$ ]] && ruby_version="v${ruby_version}"

  _prompt_section \
    "red" \
    "via " \
    "💎  ${ruby_version}" \
    " "
}

# GOLANG
# Show current version of Go
prompt_golang() {
  # If there are Go-specific files in current directory, or current directory is under the GOPATH
  [[ -d Godeps || -f glide.yaml || -n *.go(#qN^/) || -f Gopkg.yml || -f Gopkg.lock || ( $GOPATH && $PWD =~ $GOPATH ) ]] || return

  _exists go || return

  local go_version=$(go version | grep --colour=never -oE '[[:digit:]].[[:digit:]]')

  _prompt_section \
    "cyan " \
    "via " \
    "🐹 v${go_version}" \
    " "
}

# RUST
# Show current version of Rust
prompt_rust() {
  # If there are Rust-specific files in current directory
  [[ -f Cargo.toml || -n *.rs(#qN^/) ]] || return

  _exists rustc || return

  local rust_version=$(rustc --version | grep --colour=never -oE '[[:digit:]]+\.[[:digit:]]+\.[[:digit:]]')

  _prompt_section \
    "red" \
    "via " \
    "𝗥 v${rust_version}" \
    " "
}

# DOCKER
# Show current Docker version and connected machine
prompt_docker() {
  _exists docker || return

  # Show Docker status only for Docker-specific folders
  [[ -f Dockerfile || -f docker-compose.yml ]] || return

  # if docker daemon isn't running you'll get an error saying it can't connect
  docker info 2>&1 | grep -q "Cannot connect" && return

  local docker_version=$(docker version -f "{{.Server.Version}}")

  if [[ -n $DOCKER_MACHINE_NAME ]]; then
    docker_version+=" via ($DOCKER_MACHINE_NAME)"
  fi

  _prompt_section \
    "cyan" \
    "on " \
    "🐳 v${docker_version}" \
    " "
}

# Amazon Web Services (AWS)
# Shows selected AWS cli profile.
prompt_aws() {
  # Check if the AWS-cli is installed
  _exists aws || return

  # Is the current profile not the default profile
  [[ -z $AWS_DEFAULT_PROFILE ]] || [[ "$AWS_DEFAULT_PROFILE" == "default" ]] && return

  # Show prompt section
  _prompt_section \
    "208" \
    "using " \
    "☁️ $AWS_DEFAULT_PROFILE" \
    " "
}

# VENV
# Show current virtual environment (Python).
prompt_venv() {
  # Check if the current directory running via Virtualenv
  [ -n "$VIRTUAL_ENV" ] && _exists deactivate || return

  _prompt_section \
    "blue" \
    "via " \
    "$VIRTUAL_ENV:t" \
    " "
}

# KUBECONTEXT
# Show current context in kubectl.
prompt_kubecontext() {
  _exists kubectl || return
  local kube_context=$(kubectl config current-context 2>/dev/null)
  [[ -z $kube_context ]] && return

  _prompt_section \
    "cyan" \
    "at " \
    "☸️  ${kube_context}" \
    " "
}

# LINE SEPARATOR
# Write prompt in two lines
prompt_line_sep() {
  local NEWLINE='
'
  echo -n "$NEWLINE"
}

# PROMPT CHARACTER
# Paint $PROMPT_SYMBOL in red if previous command was fail and
# paint in magenta if everything was OK.
prompt_char() {
  _prompt_section "%(?.magenta.red)" "❯ "
}

# Compose whole prompt from smaller parts
prompt() {
  # Retirve exit code of last command to use in exit_code
  # Must be captured before any other command in prompt is executed
  RETVAL=$?

  # Option EXTENDED_GLOB is set locally to force filename generation on
  # argument to conditions, i.e. allow usage of explicit glob qualifier (#q).
  # See the description of filename generation in
  # http://zsh.sourceforge.net/Doc/Release/Conditional-Expressions.html
  setopt EXTENDED_GLOB LOCAL_OPTIONS

  # Add a newline before the prompt
  echo ""

  # Display prompt sections
  prompt_user
  prompt_host
  prompt_dir
  prompt_git
  prompt_ruby
  prompt_aws
  prompt_venv
  prompt_line_sep
  prompt_char
}

# Compose whole prompt from smaller parts
rprompt() {
  prompt_node
}

# PS2 - continuation interactive prompt
ps2() {
  _prompt_section "yellow" "❯ "
}

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
  PROMPT='$(prompt)'
  RPROMPT='$(rprompt)'
  PS2='$(ps2)'

  # LSCOLORS
  # Online editor: https://geoff.greer.fm/lscolors/
  export LSCOLORS="Gxfxcxdxbxegedabagacab"
  export LS_COLORS='no=00:fi=00:di=01;34:ln=00;36:pi=40;33:so=01;35:do=01;35:bd=40;33;01:cd=40;33;01:or=41;33;01:ex=00;32:ow=0;41:*.cmd=00;32:*.exe=01;32:*.com=01;32:*.bat=01;32:*.btm=01;32:*.dll=01;32:*.tar=00;31:*.tbz=00;31:*.tgz=00;31:*.rpm=00;31:*.deb=00;31:*.arj=00;31:*.taz=00;31:*.lzh=00;31:*.lzma=00;31:*.zip=00;31:*.zoo=00;31:*.z=00;31:*.Z=00;31:*.gz=00;31:*.bz2=00;31:*.tb2=00;31:*.tz2=00;31:*.tbz2=00;31:*.avi=01;35:*.bmp=01;35:*.fli=01;35:*.gif=01;35:*.jpg=01;35:*.jpeg=01;35:*.mng=01;35:*.mov=01;35:*.mpg=01;35:*.pcx=01;35:*.pbm=01;35:*.pgm=01;35:*.png=01;35:*.ppm=01;35:*.tga=01;35:*.tif=01;35:*.xbm=01;35:*.xpm=01;35:*.dl=01;35:*.gl=01;35:*.wmv=01;35:*.aiff=00;32:*.au=00;32:*.mid=00;32:*.mp3=00;32:*.ogg=00;32:*.voc=00;32:*.wav=00;32:*.patch=00;34:*.o=00;32:*.so=01;35:*.ko=01;31:*.la=00;33'
  # Zsh to use the same colors as ls
  # Link: http://superuser.com/a/707567
  zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}
}

setup "$@"

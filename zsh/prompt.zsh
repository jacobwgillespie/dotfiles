autoload colors && colors
# cheers, @ehrenmurdick
# http://github.com/ehrenmurdick/config/blob/master/zsh/prompt.zsh

is_git() {
  /usr/bin/git rev-parse --is-inside-work-tree &> /dev/null
}

git_branch() {
  echo $(/usr/bin/git rev-parse --abbrev-ref HEAD 2>/dev/null)
}

git_dirty() {
  if $(/usr/bin/git diff --quiet --exit-code HEAD .)
  then
    echo "on %{$fg_bold[green]%}$(git_branch)%{$reset_color%}"
  else
    echo "on %{$fg_bold[red]%}$(git_branch)%{$reset_color%}"
  fi
}

git_prompt_info () {
  is_git && git_dirty && need_push
}

unpushed () {
  /usr/bin/git cherry -v @{upstream} 2>/dev/null
}

need_push () {
  if [[ $(unpushed) == "" ]]
  then
    echo " "
  else
    echo " with %{$fg_bold[magenta]%}unpushed%{$reset_color%} "
  fi
}

rb_prompt(){
  if $(which rbenv &> /dev/null)
  then
    echo "%{$fg_bold[yellow]%}$(rbenv version | awk '{print $1}')%{$reset_color%}"
  else
    echo ""
  fi
}

# This keeps the number of todos always available the right hand side of my
# command line. I filter it to only count those tagged as "+next", so it's more
# of a motivation to clear out the list.
todo(){
  if $(which todo.sh &> /dev/null)
  then
    num=$(echo $(todo.sh ls +next | wc -l))
    let todos=num-2
    if [ $todos != 0 ]
    then
      echo "$todos"
    else
      echo ""
    fi
  else
    echo ""
  fi
}

directory_name(){
  echo "%{$fg_bold[cyan]%}%1/%\/%{$reset_color%}"
}

current_user(){
  echo "%{$fg_bold[yellow]%}$USER%{$reset_color%}"
}

current_host(){
  echo "%{$fg_bold[blue]%}$(hostname -s)%{$reset_color%}"
}

export PROMPT="› "
set_prompt () {
  export RPROMPT="$(rb_prompt) %{$fg_bold[cyan]%}$(todo)%{$reset_color%}"
}

precmd() {
  title "zsh" "%m" "%55<...<%~"
  set_prompt
  print -rP $'\n$(current_user) at $(current_host) in $(directory_name) $(git_prompt_info)'
}

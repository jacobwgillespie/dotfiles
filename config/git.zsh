if (( $+commands[git] )); then
  export PATH="${PATH}:$(git --exec-path)"
fi

alias g=git
alias glog="git log --graph --pretty=format:'%Cred%h%Creset %an: %s%Creset%C(yellow)%d%Creset %Cgreen(%cr)%Creset' --abbrev-commit --date=relative"
alias gp='git push origin HEAD'
alias gpf='git push origin HEAD --force-with-lease'
alias gs='git status -sb'
alias grb='git rebase --committer-date-is-author-date'
alias s='git sync'

if (( $+commands[gh] )); then
  eval "$(gh completion -s zsh)"
fi

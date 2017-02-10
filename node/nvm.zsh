export NVM_DIR=~/.nvm
if [ -e "$(brew --prefix nvm)/nvm.sh" ]; then
  nvm() {
    source $(brew --prefix nvm)/nvm.sh
    nvm "$@"
  }
fi

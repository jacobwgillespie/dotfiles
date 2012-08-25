# If MAMP is installed, add the latest PHP to the path
if [[ -d /Applications/MAMP ]]; then
  export PATH="/Applications/MAMP/bin/php/$(/bin/ls /Applications/MAMP/bin/php/ | /usr/bin/tail -1)/bin:$PATH"
fi
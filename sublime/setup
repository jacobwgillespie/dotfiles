#!/bin/sh
# Setup a machine for Sublime Text

sublime_dir=~/Library/Application\ Support/Sublime\ Text\ 3/Packages/User

for file_path in $ZSH/sublime/User/*; do
  [[ -f "$file_path" ]] || continue
  basename=$(basename "$file_path")
  echo "Linking $basename"
  ln -sfv "$file_path" "$sublime_dir/$basename" 1>/dev/null
done

echo "Done!"

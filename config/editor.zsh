# use VS Code as the system editor
export EDITOR='code --wait'

# If SSH, alias the `code` command
if [[ -n "$SSH_CLIENT" ]]; then
  alias code="code-ssh"
fi

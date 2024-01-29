# If SSH, alias the `code` command
if [[ -n "$SSH_CLIENT" ]]; then
  alias code="code-ssh"
fi

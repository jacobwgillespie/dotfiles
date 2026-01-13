# use Cursor as the system editor
export EDITOR='cursor --wait'

# If SSH, alias the `cursor` command
if [[ -n "$SSH_CLIENT" ]]; then
  alias cursor="cursor-ssh"
fi

fasd_path=$(which fasd)
if [[ -f $fasd_path ]]
then
  eval "$(fasd --init auto)"
fi
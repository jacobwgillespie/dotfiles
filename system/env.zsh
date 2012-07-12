#export EDITOR='mate -w'
export EDITOR='subl'

function buildenv() { cat .env | while read a; do echo export $a; done }
function loadenv() { buildenv > ~/.tmpenv && source ~/.tmpenv && rm ~/.tmpenv }

export EDITOR='subl'
function loadenv() { cat .env | while read a; do export $a; done }

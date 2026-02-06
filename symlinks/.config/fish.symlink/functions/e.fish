function e
    if test (count $argv) -eq 0
        if test (uname) = Darwin
            open -a Cursor .
        else if set -q SSH_CLIENT
            cursor-ssh .
        else
            cursor .
        end
    else
        if test (uname) = Darwin
            open -a Cursor $argv
        else if set -q SSH_CLIENT
            cursor-ssh $argv
        else
            cursor $argv
        end
    end
end

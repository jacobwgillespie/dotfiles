if type -q aws_completer
    function __fish_complete_aws
        env COMP_LINE=(commandline -pc) COMP_POINT=(string length -- (commandline -pc)) aws_completer 2>/dev/null
    end

    complete -c aws -e
    complete -c aws -f -a "(__fish_complete_aws)"
end

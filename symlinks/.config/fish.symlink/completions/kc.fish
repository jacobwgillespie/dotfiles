function __fish_kc_previous_context
    set -l prev_file "$HOME/.kube/kubectx"
    if test -s "$prev_file"
        echo -
    end
end

function __fish_kc_contexts
    if not type -q kubectl
        return
    end

    kubectl config get-contexts --output=name 2>/dev/null
end

complete -c kc -f -n __fish_use_subcommand -a "(__fish_kc_previous_context)"
complete -c kc -f -n __fish_use_subcommand -a "(__fish_kc_contexts)"

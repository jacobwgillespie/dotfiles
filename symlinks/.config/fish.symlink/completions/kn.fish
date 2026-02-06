function __fish_kn_namespaces
    if not type -q kubectl
        return
    end

    kubectl get namespaces -o=jsonpath='{range .items[*].metadata.name}{@}{"\n"}{end}' 2>/dev/null
end

complete -c kn -f -n __fish_use_subcommand -a "(__fish_kn_namespaces)"

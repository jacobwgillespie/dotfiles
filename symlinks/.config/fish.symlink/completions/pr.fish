function __fish_pr_numbers
    if not type -q gh
        return
    end

    gh pr list 2>/dev/null | string match -r '^[0-9]+'
end

complete -c pr -n __fish_use_subcommand -a "(__fish_pr_numbers)"

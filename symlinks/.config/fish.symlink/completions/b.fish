function __fish_b_branches
    git branch --format='%(refname:short)' 2>/dev/null
end

complete -c b -f -n __fish_use_subcommand -a "(__fish_b_branches)"

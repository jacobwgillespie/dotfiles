function __fish_c_complete_projects
    set -l token (commandline -ct)
    set -l parent (path dirname -- $token)
    set -l partial (path basename -- $token)

    if test "$parent" = "."
        set parent ""
    end

    set -l search_dir "$PROJECTS"
    if test -n "$parent"
        set search_dir "$PROJECTS/$parent"
    end

    if not test -d "$search_dir"
        return
    end

    for entry in "$search_dir"/*
        if test -d "$entry"
            set -l name (path basename -- $entry)
            if string match -q -- "$partial*" "$name"
                if test -n "$parent"
                    printf "%s\n" (string escape -- "$parent/$name/")
                else
                    printf "%s\n" (string escape -- "$name/")
                end
            end
        end
    end
end

complete -c c -e
complete -c c -f -a "(__fish_c_complete_projects)"

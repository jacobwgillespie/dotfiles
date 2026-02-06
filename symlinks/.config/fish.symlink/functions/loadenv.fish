function loadenv
    for line in (string match -rv '^\s*(#|$)' < .env)
        set -l parts (string split -m1 '=' -- $line)
        if test (count $parts) -eq 2
            set -gx $parts[1] $parts[2]
        end
    end
end

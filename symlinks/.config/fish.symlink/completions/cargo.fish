if type -q rustup
    set -l cargo_completion (rustup completions fish cargo 2>/dev/null)
    if test $status -eq 0; and test -n "$cargo_completion"
        printf "%s\n" $cargo_completion | source
    end
end

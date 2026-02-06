function __fish_run_proxy_bun_run
    if not type -q bun
        return
    end

    set -l tokens (commandline -poc)
    if test (count $tokens) -gt 0
        set -e tokens[1]
    end

    set -l cmd "bun run "
    if test (count $tokens) -gt 0
        set cmd "$cmd"(string join " " -- (string escape -- $tokens))
    end

    complete -C "$cmd"
end

complete -c run -e
complete -c run -f -a "(__fish_run_proxy_bun_run)"

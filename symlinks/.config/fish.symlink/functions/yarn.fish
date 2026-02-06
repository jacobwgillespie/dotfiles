function yarn
    _pkg_lock_hint bun.lock bun; or return 1
    _pkg_lock_hint pnpm-lock.yaml pnpm; or return 1
    _pkg_lock_hint package-lock.json npm; or return 1
    command yarn $argv
end

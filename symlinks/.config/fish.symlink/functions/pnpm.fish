function pnpm
    _pkg_lock_hint bun.lock bun; or return 1
    _pkg_lock_hint yarn.lock yarn; or return 1
    _pkg_lock_hint package-lock.json npm; or return 1
    command pnpm $argv
end

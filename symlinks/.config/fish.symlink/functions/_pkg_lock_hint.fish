function _pkg_lock_hint --argument-names lockfile manager
    if test -f $lockfile
        echo "Detected $lockfile, did you mean $manager?" >&2
        return 1
    end
    return 0
end

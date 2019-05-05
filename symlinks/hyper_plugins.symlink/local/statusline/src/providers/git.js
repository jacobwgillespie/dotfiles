import execa from 'execa'
import React, {createContext, useCallback, useContext, useMemo, useState} from 'react'
import {useCwd} from './cwd'

const GitContext = createContext({
  branch: '',
  remote: '',
  dirty: 0,
  ahead: 0,
})

export function GitProvider({children}) {
  const {cwd} = useCwd()
  const [branch, setBranch] = useState('')
  const [remote, setRemote] = useState('')
  const [dirty, setDirty] = useState(0)
  const [ahead, setAhead] = useState(0)

  const isGit = useCallback(async () => {
    const res = await execa.shell('git rev-parse --is-inside-work-tree', {reject: false, cwd})
    return res.code === 0
  }, [cwd])

  const gitBranch = useCallback(async () => {
    const res = await execa.shell('git symbolic-ref --short HEAD || git rev-parse --short HEAD', {reject: false, cwd})
    setBranch(res.stdout)
  }, [cwd])

  const gitRemote = useCallback(async () => {
    const res = await execa.shell('git ls-remote --get-url', {reject: false, cwd})
    setRemote(
      res.stdout
        .trim()
        .replace(/^git@(.*?):/, 'https://$1/')
        .replace(/[A-z0-9\-]+@/, '')
        .replace(/\.git$/, ''),
    )
  }, [cwd])

  const gitDirty = useCallback(async () => {
    const res = await execa.shell('git status --porcelain --ignore-submodules -uno', {reject: false, cwd})
    setDirty(res.stdout ? parseInt(res.stdout.trim().split('\n').length, 10) : 0)
  }, [cwd])

  const gitAhead = useCallback(async () => {
    const res = await execa.shell("git rev-list --left-only --count HEAD...@'{u}'", {reject: false, cwd})
    setAhead(parseInt(res.stdout, 10))
  }, [cwd])

  const refresh = useCallback(async () => {
    if (await isGit()) {
      gitBranch()
      gitRemote()
      gitDirty()
      gitAhead()
    } else {
      setBranch('')
      setRemote('')
      setDirty(0)
      setAhead(0)
    }
  }, [gitAhead, gitBranch, gitDirty, gitRemote, isGit])

  const value = useMemo(
    () => ({
      branch,
      remote,
      dirty,
      ahead,
      refresh,
    }),
    [branch, remote, dirty, ahead, refresh],
  )

  return <GitContext.Provider value={value}>{children}</GitContext.Provider>
}

export function useGit() {
  return useContext(GitContext)
}

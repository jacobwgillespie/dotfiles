import execa from 'execa'
import React, {createContext, useState, useCallback, useMemo, useContext} from 'react'

const CwdContext = createContext('')

export function CwdProvider({children}) {
  const [cwd, setCwd] = useState('')

  const refresh = useCallback(async pid => {
    const res = await execa.shell(`lsof -p ${pid} | awk '$4=="cwd"' | tr -s ' ' | cut -d ' ' -f9-`, {reject: false})
    setCwd(res.stdout.trim())
  })

  const value = useMemo(
    () => ({
      cwd,
      refresh,
    }),
    [cwd, refresh],
  )

  return <CwdContext.Provider value={value}>{children}</CwdContext.Provider>
}

export function useCwd() {
  return useContext(CwdContext)
}

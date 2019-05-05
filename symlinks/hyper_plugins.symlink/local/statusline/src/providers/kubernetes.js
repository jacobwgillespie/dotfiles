import execa from 'execa'
import React, {createContext, useCallback, useContext, useMemo, useState} from 'react'
import {useCwd} from './cwd'

const KubernetesContext = createContext({
  context: '',
  namespace: '',
})

export function KubernetesProvider({children}) {
  const [context, setContext] = useState('')
  const [namespace, setNamespace] = useState('')

  const refreshContext = useCallback(async () => {
    const res = await execa('/usr/local/bin/kubectl', ['config', 'current-context'], {extendEnv: true})
    setContext(res.stdout)
  }, [])

  const refreshNamespace = useCallback(async () => {
    const res = await execa(
      '/usr/local/bin/kubectl',
      ['config', 'view', '--minify', '--output', 'jsonpath={..namespace}'],
      {extendEnv: true},
    )
    setNamespace(res.stdout)
  }, [])

  const refresh = useCallback(() => {
    refreshContext()
    refreshNamespace()
  }, [refreshContext, refreshNamespace])

  const value = useMemo(
    () => ({
      context,
      namespace,
      refresh,
    }),
    [context, namespace, refresh],
  )

  return <KubernetesContext.Provider value={value}>{children}</KubernetesContext.Provider>
}

export function useKubernetes() {
  return useContext(KubernetesContext)
}

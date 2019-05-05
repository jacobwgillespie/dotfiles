export function remoteProps(initial = {}) {
  let props = {...initial}
  let listeners = []

  return {
    subscribe: fn => {
      listeners.push(fn)
      fn(props)
    },
    unsubscribe: fn => {
      listeners = listeners.filter(listener => listener === fn)
    },
    update: nextProps => {
      props = {...nextProps}
      listeners.forEach(listener => listener(props))
    },
  }
}

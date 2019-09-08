import ansiStyles from 'ansi-styles'
import execa from 'execa'
import os from 'os'
import path from 'path'
import {color, escapeForRegex, kubernetesBlue} from './utils'

export async function directory() {
  const cwd = process.cwd()
  const home = os.homedir()
  const normalizedPath = cwd.startsWith(home) ? cwd.replace(new RegExp(`^${escapeForRegex(home)}`), '~') : cwd
  const shortPath = normalizedPath
    .split(path.sep)
    .slice(-3)
    .join(path.sep)
  return color(ansiStyles.blue, shortPath)
}

export async function gitBranch() {
  const [ref, status, rev] = await Promise.all([
    execa('git', ['symbolic-ref', '--quiet', 'HEAD'], {reject: false}),
    execa('git', ['status', '--porcelain'], {reject: false}),
    execa('git', ['rev-parse', '--short', 'HEAD'], {reject: false}),
  ])

  if (ref.exitCode === 128) {
    return ''
  }

  const stdout = ref.exitCode === 0 ? ref.stdout : rev.stdout
  const branch = ` ${stdout.replace('refs/heads/', '')}`
  const isModified = status.stdout !== ''

  return `${color(ansiStyles.white, 'on')} ${
    isModified ? color(ansiStyles.magenta, branch) : color(ansiStyles.green, branch)
  }`
}

export async function gitStatus() {
  const [{stdout: index}, stash] = await Promise.all([
    execa('git', ['status', '--porcelain', '-b'], {reject: false}),
    execa('git', ['rev-parse', '--verify', 'refs/stash'], {reject: false}),
  ])
  const status = []

  // Local has diverged from remote
  if (index.match(/^## [^ ]\+ .*diverged /m)) {
    status.push('⇕')
  }

  // Local is behind remote
  if (index.match(/^## [^ ]\+ .*behind /m)) {
    status.push('⇡')
  }

  // Local is ahead of remote
  if (index.match(/^## [^ ]\+ .*ahead /m)) {
    status.push('⇡')
  }

  // Merge conflict, both files modified
  if (index.match(/^UU /m)) {
    status.push('=')
  }

  // Stashed files
  if (stash.exitCode === 0) {
    status.push('»')
  }

  // Deleted files
  if (index.match(/^ D /m) || index.match(/^D  /m) || index.match(/^AD /m)) {
    status.push('✘')
  }

  // Renamed files
  if (index.match(/^R  /m)) {
    status.push('»')
  }

  // Modified files
  if (index.match(/^ M /m) || index.match(/^AM /m) || index.match(/^ T /m)) {
    status.push('!')
  }

  // Added files
  if (index.match(/^A  /m) || index.match(/^M  /m)) {
    status.push('+')
  }

  // Untracked files
  if (index.match(/^\?\? /m)) {
    status.push('?')
  }

  return status.length ? color(ansiStyles.red, status.join('')) : ''
}

export async function kubernetes() {
  const [ctx, ns] = await Promise.all([
    execa('kubectl', ['config', 'current-context'], {reject: false}),
    execa('kubectl', ['config', 'view', '--minify', '--output', 'jsonpath={..namespace}'], {reject: false}),
  ])

  if (ctx.exitCode !== 0) {
    return ''
  }

  const context = ctx.stdout
  const namespace = ns.stdout || 'default'

  return color(kubernetesBlue, `⎈ ${context} ${color(ansiStyles.gray, namespace)}`)
}

export async function node() {
  const node = await execa('node -v', {reject: false, shell: true})
  return node.exitCode === 0 ? color(ansiStyles.green, `⬢ ${node.stdout}`) : ''
}

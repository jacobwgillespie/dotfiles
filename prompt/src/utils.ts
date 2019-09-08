import ansiStyles from 'ansi-styles'
import {EscapeCode} from 'ansi-styles/escape-code'
import * as sections from './sections'
import {Sections} from './types'

const shell = process.argv[3]
export function escapeForShell(ansiCode: string) {
  switch (shell) {
    case 'sh':
    case 'bash':
      return '\x01' + ansiCode + '\x02'
    case 'zsh':
      return '%{' + ansiCode + '%}'
    case 'fish':
      return ansiCode
    default:
      return ansiCode
  }
}

export function escapeForRegex(input: string) {
  return input.replace(/[\-\[\]\/\{\}\(\)\*\+\?\.\\\^\$\|]/g, '\\$&')
}

export const kubernetesBlue: EscapeCode.CodePair = {
  open: `\u001B[38;5;33m`,
  close: `\u001B[39m`,
}

export function color(style: EscapeCode.CodePair, text: string) {
  return `${escapeForShell(style.open)}${text}${escapeForShell(style.close)}`
}

export async function renderPrompt(sectionNames: Sections, style: 'prompt' | 'rprompt' | 'ps2' = 'prompt') {
  const promptChar = color(ansiStyles.bold, '❯ ')

  if (style === 'ps2') {
    console.log(color(ansiStyles.yellow, promptChar))
    return
  }

  if (style === 'prompt') {
    console.log()
  }

  // Display prompt sections
  const promptParts = await Promise.all(sectionNames.map(section => sections[section]()))
  const prompt = promptParts.filter(part => part !== '')
  console.log(color(ansiStyles.bold, prompt.join(' ')))

  // Display prompt character
  if (style === 'prompt') {
    console.log(process.argv[4] === '0' ? color(ansiStyles.magenta, promptChar) : color(ansiStyles.red, promptChar))
  }
}

const binaryLocation = process.execPath
const zshInit = `
custom_prompt() {
  exit_code="$?"
  ${binaryLocation} prompt zsh $exit_code
}

custom_rprompt() {
  ${binaryLocation} rprompt zsh
}

custom_ps2() {
  ${binaryLocation} rprompt zsh
}

PROMPT='$(custom_prompt)'
RPROMPT='$(custom_rprompt)'
PS2='$(custom_ps2)'
`.trim()

export async function initPrompt(shell: string) {
  switch (shell) {
    case 'zsh':
      return console.log(zshInit)

    case 'bash':
      return console.log('')

    default:
      throw new Error(`Unknown shell: ${shell}`)
  }
}

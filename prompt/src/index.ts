process.env.FORCE_COLOR = 'true'

import {Sections} from './types'
import {initPrompt, renderPrompt} from './utils'

const presentationMode = Boolean(process.env.PROMPT_PRESENTATION_MODE)
const PROMPT: Sections = presentationMode ? ['directory'] : ['directory', 'gitBranch', 'gitStatus']
const RPROMPT: Sections = presentationMode ? [] : ['kubernetes', 'node']

async function run() {
  switch (process.argv[2]) {
    case 'prompt': {
      return await renderPrompt(PROMPT)
    }

    case 'rprompt': {
      return await renderPrompt(RPROMPT, 'rprompt')
    }

    case 'ps2': {
      return await renderPrompt([], 'ps2')
    }

    case 'init': {
      return await initPrompt(process.argv[3])
    }

    default:
      return
  }
}

run().catch(() => {
  process.exit(1)
})

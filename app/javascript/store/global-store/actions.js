import { T } from './types'

export const actions = {
  [T.HOGE] ({ commit }, str) {
    console.log('hoge action')
    commit(T.HOGE, str)
  }
}


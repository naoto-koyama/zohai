import { T } from './types'

export const mutations = {
  [T.HOGE] (state, str) {
    console.log('hoge mutations')
    state.searchStr = str
  }
}

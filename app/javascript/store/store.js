import Vue from 'vue'
import Vuex from 'vuex'
import state from './global-store/state'
import { getters } from './global-store/getters'
import { mutations } from './global-store/mutations'
import { actions } from './global-store/actions'

Vue.use(Vuex)

export default new Vuex.Store({
  state,
  getters,
  actions,
  mutations
})

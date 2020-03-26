import { T } from './types'
import axios from "axios";

export const actions = {
  [T.LOAD_BRAND_LATEST_DIVIDEND] ({ commit }) {
    axios
      .get('/api/dividends.json')
      .then(response => {
        commit(T.LOAD_BRAND_LATEST_DIVIDEND, response.data)
      })
  },
  [T.GET_DIVIDEND_TREND] ({ commit }, id) {
    axios
      .get('/api/dividend_trends/' + id + '.json')
      .then(response => {
        commit(T.GET_DIVIDEND_TREND, response.data)
      })
  },
  [T.SORT_BRAND_LATEST_DIVIIEDEND] ({ commit, state }, sort_column) {
    let sort_order = (sort_column === state.sort_column && state.sort_order === 'asc') ? 'desc' : 'asc'
    commit(T.SORT_BRAND_LATEST_DIVIIEDEND, { sort_column: sort_column, sort_order: sort_order })
  },
  [T.CLOSE_DIVIDEND_TREND] ({ commit }) {
    commit(T.CLOSE_DIVIDEND_TREND)
  }
}


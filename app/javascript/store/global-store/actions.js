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
  }
}


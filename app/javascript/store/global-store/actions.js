import { T } from './types'
import axios from "axios";

export const actions = {
  [T.LOAD_BRAND_LATEST_DIVIDEND] ({ commit, state }) {
    axios
      .get('/api/dividends.json')
      .then(response => {
        let total_page = Math.ceil(response.data.length / state.pagenate_slice_no);
        commit(T.LOAD_BRAND_LATEST_DIVIDEND, { brand_latest_dividends: response.data, total_page: total_page })
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
  },
  [T.CLICK_PAGENATE] ({ commit }, page_no) {
    commit(T.CLICK_PAGENATE, page_no)
  },
  [T.CLICK_PREV_PAGENATE] ({ commit, state }) {
    if (state.current_page === 1) return
      commit(T.CLICK_PAGENATE, state.current_page - 1)
  },
  [T.CLICK_NEXT_PAGENATE] ({ commit, state }) {
    if (state.current_page === state.total_page) return
    commit(T.CLICK_PAGENATE, state.current_page + 1)
  },
  [T.CLICK_FIRST_PAGE] ({ commit }) {
    commit(T.CLICK_PAGENATE, 1)
  },
  [T.CLICK_LAST_PAGE] ({ commit, state }) {
    console.log(state.total_page)
    commit(T.CLICK_PAGENATE, state.total_page)
  }
}


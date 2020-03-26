import { T } from './types'

export const mutations = {
  [T.LOAD_BRAND_LATEST_DIVIDEND] (state, brand_latest_dividends) {
    state.brand_latest_dividends = brand_latest_dividends
  },
  [T.GET_DIVIDEND_TREND] (state, dividend_trends) {
    state.dividend_trends = dividend_trends
    state.is_show_detail = true
  },
  [T.SORT_BRAND_LATEST_DIVIIEDEND] (state, { sort_column, sort_order }) {
    state.sort_column = sort_column
    state.sort_order = sort_order
  },
  [T.CLOSE_DIVIDEND_TREND] (state) {
    state.is_show_detail = false
  }
}

import { T } from './types'

export const mutations = {
  [T.LOAD_BRAND_LATEST_DIVIDEND] (state, brand_latest_dividends) {
    state.brand_latest_dividends = brand_latest_dividends
  },
  [T.GET_DIVIDEND_TREND] (state, dividend_trends) {
    state.dividend_trends = dividend_trends
  }
}

import { T } from './types'

export const mutations = {
  [T.LOAD_BRAND_LATEST_DIVIDEND] (state, { brand_latest_dividends, total_page }) {
    state.brand_latest_dividends = brand_latest_dividends
    state.total_page = total_page
    state.loading = false
  },
  [T.GET_DIVIDEND_TREND] (state, dividend_trends) {
    state.dividend_trends = dividend_trends
    state.is_show_detail = true
  },
  [T.SORT_BRAND_LATEST_DIVIIEDEND] (state, { sort_column, sort_order }) {
    state.sort_column = sort_column
    state.sort_order = sort_order
    state.current_page = 1
  },
  [T.CLOSE_DIVIDEND_TREND] (state) {
    state.is_show_detail = false
  },
  [T.CLICK_PAGENATE] (state, page_no) {
    state.current_page = page_no
  },
  [T.CLICK_PAGENATE] (state, page_no) {
    state.current_page = page_no
  },
  [T.CHANGE_MONTH] (state, { search_months, total_page }) {
    state.total_page = total_page
    state.current_page = 1
    state.is_show_detail = false
    state.search_months = search_months
  },
  [T.CHANGE_SEARCH_CHAR] (state, { search_text, total_page }) {
    state.search_text = search_text
    state.total_page = total_page
    state.current_page = 1
    state.is_show_detail = false
  }
}

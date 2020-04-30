import { T } from './types'

export const mutations = {
  [T.LOAD_BRAND_LATEST_DIVIDEND] (state, { brandLatestDividends, totalPage }) {
    state.brandLatestDividends = brandLatestDividends
    state.totalPage = totalPage
    state.loading = false
  },
  [T.GET_DIVIDEND_TREND] (state, dividendTrends) {
    state.dividendTrends = dividendTrends
  },
  [T.SORT_BRAND_LATEST_DIVIIEDEND] (state, { sortColumn, sortOrder }) {
    state.sortColumn = sortColumn
    state.sortOrder = sortOrder
    state.currentPage = 1
  },
  [T.CLICK_PAGENATE] (state, pageNo) {
    state.currentPage = pageNo
  },
  [T.CLICK_PAGENATE] (state, pageNo) {
    state.currentPage = pageNo
  },
  [T.CHANGE_MONTH] (state, { searchMonths, totalPage }) {
    state.totalPage = totalPage
    state.currentPage = 1
    state.searchMonths = searchMonths
  },
  [T.CHANGE_SEARCH_CHAR] (state, { searchText, totalPage }) {
    state.searchText = searchText
    state.totalPage = totalPage
    state.currentPage = 1
  },
  [T.GET_BRAND] (state, brand) {
    state.brand = brand
  }
}

import _ from 'lodash'

export const getters = {
  getBrandLatestDividends(state) {
    return _.orderBy(state.brand_latest_dividends, state.sort_column, state.sort_order)
  },
  getDividendTrends(state) {
    return state.dividend_trends
  },
  getIsShowDetail(state) {
    return state.is_show_detail
  },
  getOrderClass: (state) => (column) => {
    if (state.sort_column === column) {
      return {
        'p-asc': state.sort_order === "asc",
        'p-desc': state.sort_order === "desc"
      }
    }

    return {
      'p-asc': false,
      'p-desc': false
    }
  }
}

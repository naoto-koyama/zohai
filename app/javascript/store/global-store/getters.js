import _ from 'lodash'

export const getters = {
  getLoading(state) {
    return state.loading
  },
  getBrandLatestDividends(state, getters) {
    let start = (state.current_page - 1) * state.pagenate_slice_no
    let end = state.current_page * state.pagenate_slice_no
    return _.orderBy(getters.getFilteredBrandLatestDividends(state.search_text, state.search_months), state.sort_column, state.sort_order).slice(start, end)
  },
  getFilteredBrandLatestDividends: (state, getters) => (search_text, search_months) => {
    let tmp_brand_latest_dividends =  getters._filterBrandLatestDividendsByText(state.brand_latest_dividends, search_text)
    return getters._filterBrandLatestDividendsByMonth(tmp_brand_latest_dividends, search_months)
  },
  _filterBrandLatestDividendsByText: (state) => (brand_latest_dividends, search_text) => {
    if (search_text === '') return brand_latest_dividends
    return brand_latest_dividends.filter((brand_latest_dividend) => {
      return brand_latest_dividend.code.indexOf(search_text) > -1 || brand_latest_dividend.name.indexOf(search_text) > -1
    })
  },
  _filterBrandLatestDividendsByMonth: (state) => (brand_latest_dividends, search_months) => {
    if (search_months.length === 0) return brand_latest_dividends
    return brand_latest_dividends.filter((brand_latest_dividend) => {
      return search_months.indexOf(brand_latest_dividend.fiscal_year.substr(5, 2)) !== -1
    })
  },
  getDividendTrends(state) {
    return state.dividend_trends
  },
  getIsShowDetail(state) {
    return state.is_show_detail
  },
  getPagenateSliceNo(state) {
    return state.pagenate_slice_no
  },
  getTotalPage(state) {
    return state.total_page
  },
  getCurrentPage(state) {
    return state.current_page
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
  },
  prevClass(state, getters) {
    return {
      "hide": getters.isFirstPage,
      "waves-effect": !getters.isFirstPage,
    }
  },
  nextClass(state, getters) {
    return {
      "hide": getters.isLastPage,
      "waves-effect": !getters.isLastPage,
    }
  },
  isFirstPage: (state) => {
    return state.current_page === 1
  },
  isLastPage: (state) => {
    return state.current_page === state.total_page || state.total_page === 0
  }
}

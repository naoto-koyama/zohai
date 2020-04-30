import _ from 'lodash'

export const getters = {
  getLoading(state) {
    return state.loading
  },
  getBrandLatestDividends(state, getters) {
    let start = (state.currentPage - 1) * state.pagenateSliceNo
    let end = state.currentPage * state.pagenateSliceNo
    return _.orderBy(getters.getFilteredBrandLatestDividends(state.searchText, state.searchMonths), state.sortColumn, state.sortOrder).slice(start, end)
  },
  getFilteredBrandLatestDividends: (state, getters) => (searchText, searchMonths) => {
    let tmp_brandLatestDividends =  getters._filterBrandLatestDividendsByText(state.brandLatestDividends, searchText)
    return getters._filterBrandLatestDividendsByMonth(tmp_brandLatestDividends, searchMonths)
  },
  _filterBrandLatestDividendsByText: (state) => (brandLatestDividends, searchText) => {
    if (searchText === '') return brandLatestDividends
    return brandLatestDividends.filter((brandLatestDividend) => {
      return brandLatestDividend.code.indexOf(searchText) > -1 || brandLatestDividend.name.indexOf(searchText) > -1
    })
  },
  _filterBrandLatestDividendsByMonth: (state) => (brandLatestDividends, searchMonths) => {
    if (searchMonths.length === 0) return brandLatestDividends
    return brandLatestDividends.filter((brandLatestDividend) => {
      return searchMonths.indexOf(brandLatestDividend.fiscal_year.substr(5, 2)) !== -1
    })
  },
  getDividendTrends(state) {
    return state.dividendTrends
  },
  getBrand(state) {
    return state.brand
  },
  getPagenateSliceNo(state) {
    return state.pagenateSliceNo
  },
  getTotalPage(state) {
    return state.totalPage
  },
  getCurrentPage(state) {
    return state.currentPage
  },
  getOrderClass: (state) => (column) => {
    if (state.sortColumn === column) {
      return {
        'p-asc': state.sortOrder === "asc",
        'p-desc': state.sortOrder === "desc"
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
    return state.currentPage === 1
  },
  isLastPage: (state) => {
    return state.currentPage === state.totalPage || state.totalPage === 0
  }
}

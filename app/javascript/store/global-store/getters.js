import _ from 'lodash'

export const getters = {
  getBrandLatestDividends(state) {
    let start = (state.current_page - 1) * state.pagenate_slice_no
    let end = state.current_page * state.pagenate_slice_no
    return _.orderBy(state.brand_latest_dividends, state.sort_column, state.sort_order).slice(start, end)
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
  getDisplayPageNos(state) {
    let display_page_nos = []
    let page_no = 1
    do {
      if (state.current_page - 2 <= page_no && page_no <= state.current_page + 6) display_page_nos.push(page_no)
      page_no ++
    } while (page_no <= state.total_page && display_page_nos.length !== 8)
    return display_page_nos
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
  pageClass: (state) => (page_no) => {
    return {
      "active": state.current_page === page_no,
      "waves-effect": (state.current_page - 2 !== page_no) && (state.current_page + 5 !== page_no)
    }
  },
  isFirstPage: (state) => {
    return state.current_page === 1
  },
  isLastPage: (state) => {
    return state.current_page === state.total_page
  }
}

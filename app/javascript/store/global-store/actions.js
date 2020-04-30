import { T } from './types'
import axios from "axios";

export const actions = {
  async [T.LOAD_BRAND_LATEST_DIVIDEND] ({ commit, state }) {
    const _response = await axios.get('/api/brand_latest_dividends.json')
    const _brandLatestDividends = _response.data
    const _totalPage = Math.ceil(_brandLatestDividends.length / state.pagenateSliceNo)
    commit(T.LOAD_BRAND_LATEST_DIVIDEND, { brandLatestDividends: _brandLatestDividends, totalPage: _totalPage })
  },
  [T.LOAD_DIVIDEND_TRENDS] ({ dispatch }, brandCode) {
    dispatch(T.GET_DIVIDEND_TRENDS, brandCode)
    dispatch(T.GET_BRAND, brandCode)
  },
  async [T.GET_DIVIDEND_TRENDS] ({ commit }, brandCode) {
    const _response = await axios.get(`/api/dividend_trends/${brandCode}.json`)
    const _dividendTrends = _response.data
    commit(T.GET_DIVIDEND_TRENDS, _dividendTrends)
  },
  async [T.GET_BRAND] ({ commit }, brandCode) {
    const _response = await axios.get(`/api/brands/${brandCode}.json`)
    const _brand = _response.data
    commit(T.GET_BRAND, _brand)
  },
  [T.SORT_BRAND_LATEST_DIVIIEDEND] ({ commit, state }, sortColumn) {
    let sortOrder = (sortColumn === state.sortColumn && state.sortOrder === 'asc') ? 'desc' : 'asc'
    commit(T.SORT_BRAND_LATEST_DIVIIEDEND, { sortColumn: sortColumn, sortOrder: sortOrder })
  },
  [T.CLOSE_DIVIDEND_TREND] ({ commit }) {
    commit(T.CLOSE_DIVIDEND_TREND)
  },
  [T.CLICK_PAGENATE] ({ commit }, pageNo) {
    commit(T.CLICK_PAGENATE, pageNo)
  },
  [T.CLICK_PREV_PAGENATE] ({ commit, state }) {
    if (state.currentPage === 1) return
      commit(T.CLICK_PAGENATE, state.currentPage - 1)
  },
  [T.CLICK_NEXT_PAGENATE] ({ commit, state }) {
    if (state.currentPage === state.totalPage) return
    commit(T.CLICK_PAGENATE, state.currentPage + 1)
  },
  [T.CLICK_FIRST_PAGE] ({ commit }) {
    commit(T.CLICK_PAGENATE, 1)
  },
  [T.CLICK_LAST_PAGE] ({ commit, state }) {
    commit(T.CLICK_PAGENATE, state.totalPage)
  },
  [T.CHANGE_MONTH] ({ commit, state, getters }, searchMonths) {
    let totalPage = Math.ceil(getters.getFilteredBrandLatestDividends(state.searchText, searchMonths).length / state.pagenateSliceNo)
    commit(T.CHANGE_MONTH, { searchMonths: searchMonths, totalPage: totalPage })
  },
  [T.CHANGE_SEARCH_CHAR] ({ commit, state, getters }, searchText) {
    let totalPage = Math.ceil(getters.getFilteredBrandLatestDividends(searchText, state.searchMonths).length / state.pagenateSliceNo)
    commit(T.CHANGE_SEARCH_CHAR, { searchText: searchText, totalPage: totalPage})
  }
}


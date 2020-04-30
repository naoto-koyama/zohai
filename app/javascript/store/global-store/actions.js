import { T } from './types'
import axios from "axios";

export const actions = {
  async [T.LOAD_BRAND_LATEST_DIVIDEND] ({ commit, state }) {
    const response = await axios.get('/api/brand_latest_dividends.json')
    const totalPage = Math.ceil(response.data.length / state.pagenateSliceNo)
    commit(T.LOAD_BRAND_LATEST_DIVIDEND, { brandLatestDividends: response.data, totalPage: totalPage })
  },
  async [T.GET_DIVIDEND_TREND] ({ commit }, id) {
    const _response = await axios.get(`/api/dividend_trends/${id}.json`)
    const _dividendTrends = response.data
    commit(T.GET_DIVIDEND_TREND, _dividendTrends)
  },
  async [T.GET_BRAND] ({ commit }, brandId) {
    const _response = await axios.get(`/api/brands/${brandId}.json`)
    const _brand = response.data
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
  },
  [T.SET_DIVIDEND_TRENDS] ({ commit, dispatch }, dividendId) {
    dispatch(T.GET_DIVIDEND_TREND(dividendId))
    dispatch(T.GET_BRAND, dividendId)
  }
}


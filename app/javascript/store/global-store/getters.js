export const getters = {
  getHoge (state) {
    console.log(state.searchStr)
    return state.searchStr
  }
}

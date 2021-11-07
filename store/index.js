export const state = () => ({
  view: 'map',
})

export const mutations = {
  SET_VIEW(state, value) {
    state.view = value
  },
}

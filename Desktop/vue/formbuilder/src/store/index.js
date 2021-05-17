import Vue from 'vue'
import Vuex from 'vuex'
import state from './state'
import getters from './getters'
import mutations from './mutations'
import actions from './actions'

Vue.use(Vuex)
// Initializing and exporting the vuex store with state, getters, mutations and actions
export default new Vuex.Store({
  state,
  getters,
  mutations,
  actions
})

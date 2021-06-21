export const onDrawer = ({ commit }) => {
    commit('setDrawer')
}

export const onDrawerPages = ({ commit }, payload) => {
    commit('setDrawerPages', payload)
}

export const fetchPages = ({ commit }, payload) => {
    commit('setPages', payload)
}

export const onSelectedPage = ({ commit }, payload) => {
    commit('setSelectedPage', payload)
}

export const onLoadingPage = ({ commit }, payload) => {
    commit('setLoadingPage', payload)
}
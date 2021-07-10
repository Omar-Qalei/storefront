export const onShowSnackbar = ({ commit }, payload) => {
    commit('setShowSnackbar', payload)
}

export const onShowMenu = ({ commit }) => {
    commit('setShowMenu')
};

export const fetchDataMenu = ({ commit }, payload) => {
    commit('setDataMenu', payload)
}

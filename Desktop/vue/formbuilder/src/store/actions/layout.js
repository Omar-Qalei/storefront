const data = [
    { id: 1, title: "Home", icon: "mdi-page-layout-header" },
    { id: 2, title: "About", icon: "mdi-page-layout-header" },
    { id: 3, title: "Services", icon: "mdi-page-layout-header" },
];

export const onDrawer = ({ commit }) => {
    commit('setDrawer')
}

export const onDrawerPages = ({ commit }, payload) => {
    commit('setDrawerPages', payload)
}

export const fetchPages = ({ commit }) => {

    commit('setPages', data)
}

export const onSelectedPage = ({ commit }, payload) => {
    commit('setSelectedPage', payload)
}
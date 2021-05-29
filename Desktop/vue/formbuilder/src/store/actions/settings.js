export const onSelectedWidgetById = ({ commit }, payload) => {
    commit('setSelectedWidgetById', payload)
}

export const onAddFormField = ({ commit }, payload) => {
    commit('setAddFormField', payload)
}

export const onRemoveFormField = ({ commit }, payload) => {
    commit('setRemoveFormField', payload)
}

export const onTextHeight = ({ commit }) => {
    commit('setTextHeight')
    commit('setSortSectionsLayout')
}

export const onRemoveBreakLines = ({ commit }) => {
    commit('setRemoveBreakLines')
    // commit('setSortSectionsLayout')
}

export const onCheckGridHeight = ({ commit }) => {
    commit('checkGridHeight')
    commit('setSortSectionsLayout')
}
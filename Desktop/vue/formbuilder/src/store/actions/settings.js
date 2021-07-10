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
    console.log('onTextHeight')
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

export const onShowChooseFilesDialog = ({ commit }, payload) => {
    commit('setShowChooseFilesDialog', payload)
}

export const onTypeChooseFileDialog = ({ commit }, payload) => {
    commit('setTypeChooseFileDialog', payload)
}
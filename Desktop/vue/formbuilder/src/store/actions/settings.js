export const onSelectedWidgetById = ({ commit }, payload) => {
    commit('setSelectedWidgetById', payload)
}

export const onAddFormField = ({ commit }, payload) => {
    commit('setAddFormField', payload)
}

export const onRemoveFormField = ({ commit }, payload) => {
    commit('setRemoveFormField', payload)
}
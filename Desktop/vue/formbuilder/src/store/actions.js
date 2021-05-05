import * as lib from './lib';

export const onDrawer = ({ commit }) => {
    commit('setDrawer')
}

// Action to fetch sections and set in state through the mutation
export const fetchSections = ({ commit }, payload) => {
    let g = lib.guid()
    let k = { id: 0, 'x': 0, 'y': 0, 'w': 12, 'h': 4, 'i': g, 'type': 'section', resources: [], refGridLayout: [], selectedIndex: 0 }
    if (payload === undefined) {
        commit('setSections', [k])
    } else {
        commit('setSections', payload)
    }
}

// Action to fetch resources and set in state through the mutation
export const fetchResources = ({ commit }, payload) => {
    if (payload === undefined) {
        commit('setResources', [])
    } else {
        commit('setResources', payload)
    }
}

export const addNewSection = ({ commit, state }, payload) => {
    let g = lib.guid()
    let k = { id: state.sections.length, 'x': 0, 'y': 0, 'w': 12, 'h': 4, 'i': g, 'type': 'section', resources: [], refGridLayout: [], selectedIndex: payload }
    commit('setNewSection', k)
}

export const onSetElement = ({ commit }, payload) => {
    commit('setElement', payload)
}

export const onSetLayout = ({ commit }, payload) => {
    commit('setLayout', payload)
}

export const onDragOver = ({ commit }, payload) => {
    commit('setDragOver', payload)
}

export const onDrag = ({ commit, state }) => {
    let k = { 'x': (state.resources.length * 2) % (state.properties.colNum || 8), 'y': state.resources.length + (state.properties.colNum || 8), 'w': state.element.width, 'h': state.element.height, 'i': "drop", 'type': state.element.type }
    commit('setDrag', k);
}


export const onDragGrid = ({ commit, state }) => {
    let k = { 'x': (state.resources.length * 2) % (state.properties.colNum || 12), 'y': state.resources.length + (state.properties.colNum || 12), 'w': state.element.width, 'h': state.element.height, 'i': "drop", 'type': state.element.type, layouts: state.element.layouts }
    commit('setDrag', k);
}

export const onDragend = ({ commit, state }) => {
    let g = lib.guid()
    let k = { 'x': state.dragPos.x, 'y': state.dragPos.y, 'w': state.element.width, 'h': state.element.height, 'i': g, 'type': state.element.type }
    commit('setDragEnd', k)
}

// If still mousedown set push false or true otherwise
export const onMoveElement = ({ commit }, payload) => {
    commit('setMoveElement', payload)
}

export const onMouseTouched = ({ commit }, payload) => {
    commit('setMouseTouched', payload)
}

// For remove duplicated dropped on multiple section from reference children and resources array 
export const onRemoveDuplicated = ({ commit }, payload) => {
    commit('removedDuplicated', payload)
}

export const updateSectionLayout = ({ commit }, payload) => {
    commit('setUpdateSectionLayout', payload)
}

export const elementSizePx = ({ commit, state }, payload) => {
    console.log(state);
    let k = { 'w': payload.w, 'h': payload.h }
    commit('setElementSizePx', k)
}

export const onSelectedSectionByIndex = ({ commit }, payload) => {
    commit('setSelectedSection', payload)
}
import * as lib from '../lib';

// Action to fetch sections and set in state through the mutation
export const fetchSections = ({ commit }, payload) => {
    let g = lib.guid()
    let k = {
        id: 0, 'x': 0, 'y': 0, 'w': 12, 'h': 10, 'i': g, 'type': 'section', resources: [], refGridLayout: [], selectedIndex: 0, resize: {
            status: false,
            h: 10
        }
    }
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
    let k = {
        id: state.sections.length, 'x': 0, 'y': 0, 'w': 12, 'h': 10, 'i': g, 'type': 'section', resources: [], refGridLayout: [], selectedIndex: payload, resize: {
            status: false,
            h: 10
        }
    }
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
    let k = {
        'x': (state.resources.length * 2) % (state.properties.colNum || 2), 'y': state.resources.length + (state.properties.colNum || 2), 'w': state.element.width, 'h': state.element.height, 'i': "drop", 'type': state.element.type,
        properties: {
            name: state.element.type,
            style: null
        }
    }
    commit('setDrag', k);
}

export const onDragend = ({ commit, state }) => {
    let g = lib.guid()
    let k = {
        'x': state.dragPos.x, 'y': state.dragPos.y, 'w': state.element.width, 'h': state.element.height, 'i': g, 'type': state.element.type, properties: {
            name: state.element.type,
            style: null,
            elementHover: null
        }
    }
    commit('setDragEnd', k)
}

// If still mousedown set push false or true otherwise
export const onMoveElement = ({ commit }, payload) => {
    commit('setMoveElement', payload)
}

export const onMouseTouched = ({ commit }, payload) => {
    commit('setMouseTouched', payload)
}

// For update refs after each actions
export const onUpdateRefs = ({ commit }, payload) => {
    commit('setUpdateRefs', payload)
}

export const updateSectionLayout = ({ commit }, payload) => {
    commit('setUpdateSectionLayout', payload)
}

export const onSelectedSection = ({ commit }, payload) => {
    commit('setSelectedSection', payload)
}

export const onResizeSection = ({ commit }, payload) => {
    commit('setResizeSection', payload)
}

export const onUpdateSectionLayoutGridResized = ({ commit }, payload) => {
    commit('setUpdateSectionLayoutGridResized', payload)
}

export const onUpdateSectionLayoutResized = ({ commit }, payload) => {
    commit('setUpdateSectionLayoutResized', payload)
}

export const onResizeSectionScreen = ({ commit }, payload) => {
    commit('setResizeSectionScreen', payload)
}
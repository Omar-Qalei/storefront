import * as lib from '../lib';

// Action to fetch sections and set in state through the mutation
export const fetchSections = ({ commit, state }, payload) => {
    let g = lib.guid()
    let k = {
        id: 0, 'x': 0, 'y': 0, 'w': 12, 'h': 10, 'i': g, 'type': 'section', resources: [], refGridLayout: [], selectedIndex: 0, resize: {
            status: false,
            h: 10,
        },
        collides: true,
        properties: {
            name: state.element.type,
            style: null,
            elementHover: null,
            backgroundVideo: null
        },
    }
    if (!payload.length) {
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

// Action to duplicate element
export const onDuplicateResource = ({ commit, state }, payload) => {
    let g = lib.guid()
    let k;
    if (payload.item.type !== 'section') {
        k = {
            'x': payload.item.x, 'y': payload.item.y, 'w': payload.item.w, 'h': payload.item.h, 'i': g, 'type': payload.item.type,
            properties: {
                name: payload.item.type,
                style: payload.item.properties.style,
                elementHover: payload.item.properties.elementHover,
                fields: payload.item.properties.fields,
                map: payload.item.properties.map,
                text: payload.item.properties.text,
            }
        }
        k.i = g;
        commit('duplicateResource', { k: k, id: payload.id })
    } else {
        k = {
            collides: payload.item.collides,
            h: payload.item.h,
            i: "",
            moved: payload.item.moved,
            properties: {
                name: payload.item.type,
                style: payload.item.properties.style,
                elementHover: payload.item.properties.elementHover,
                backgroundVideo: payload.item.properties.backgroundVideo
            },
            resize: payload.item.resize,
            resources: [],
            type: "section",
            w: payload.item.w,
            x: payload.item.x,
            y: payload.item.y,
        }
        k.i = g;
        let max = 0;
        state.sections.forEach(element => {
            console.log('element.id', element.id)
            if (max === 0) {
                max += 1;
            }
            if (max <= element.id) {
                max += element.id;
            }
        });
        k.id = max;
        payload.item.resources.forEach(element => {
            const i = element.i;
            if (element.i !== lib.guid()) {
                k.resources.push({
                    'x': element.x, 'y': element.y, 'w': element.w, 'h': element.h, 'i': lib.guid(), 'type': element.type,
                    properties: {
                        name: element.type,
                        style: element.properties.style,
                        elementHover: element.properties.elementHover,
                        fields: element.properties.fields,
                        map: element.properties.map,
                        text: element.properties.text,
                    }
                });
            }
            element.i = i;
        });
        commit('duplicateSection', k)
    }
}

// Action to remove element
export const onRemoveResource = ({ commit }, payload) => {
    if (payload.type !== 'section') {
        commit('removeResource', payload)
    } else {
        commit('removeSection', payload)
    }
}

export const addNewSection = ({ commit, state }, payload) => {
    let g = lib.guid()
    let k = {
        id: state.sections.length, 'x': 0, 'y': 0, 'w': 12, 'h': 10, 'i': g, 'type': 'section', resources: [], refGridLayout: [], selectedIndex: payload, resize: {
            status: false,
            h: 10,
        },
        collides: true,
        properties: {
            name: state.element.type,
            style: null,
            elementHover: null,
            backgroundVideo: null
        },
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
        'x': (state.resources.length * 2) % (state.properties.colNum || 2), 'y': state.resources.length + (state.properties.colNum || 2), 'w': state.element.width, 'h': state.element.height,
        'i': "drop", 'type': state.element.type,
        properties: {
            name: state.element.type,
            style: null,
            elementHover: null,
            fields: [],
            map: null,
            text: 'Write your text here'
        }
    }
    commit('setDrag', k);
}

export const onDragend = ({ commit, state }) => {
    let g = lib.guid()
    let k = {
        'x': state.dragPos.x, 'y': state.dragPos.y, 'w': state.element.width, 'h': state.element.height, 'i': g, 'type': state.element.type,
        properties: {
            name: state.element.type,
            style: null,
            elementHover: null,
            fields: [],
            map: null,
            text: 'Write your text here'
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


export const onSortSectionsLayout = ({ commit }) => {
    commit('setSortSectionsLayout')
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

export const onRearrangementResources = ({ commit }) => {
    commit('rearrangementResources')
}

export const onCheckUpdateSectionLayoutResized = ({ commit }, payload) => {
    commit('checkUpdateSectionLayoutResized', payload)
}

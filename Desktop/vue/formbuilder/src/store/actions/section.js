import * as lib from '../lib';

export const fetchSiteId = ({ commit }, payload) => {
    commit('setSiteId', payload)
}

export const fetchPageId = ({ commit }, payload) => {
    commit('setPageId', payload)
}

export const fetchCols = ({ commit }, payload) => {
    commit('setCols', payload)
}

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

export const fetchWebResources = ({ commit, state }, payload) => {
    let g = lib.guid();
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
    if (payload === null || payload === undefined) {
        commit('setWebResources', [k])
    } else {
        commit('setWebResources', payload)
    }
};
export const fetchMobileResources = ({ commit, state }, payload) => {
    let g = lib.guid();
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
    if (payload === null || payload === undefined) {
        commit('setMobileResources', [k])
    } else {
        commit('setMobileResources', payload)
    }
};

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
    let arrKeys = [];
    if (payload.item.type === 'section')
        payload.item.resources.forEach(() => arrKeys.push(lib.guid()));
    onDuplicateResourceWeb({ commit, state }, { ...payload, g: g, arrKeys: arrKeys });
    onDuplicateResourceMobile({ commit, state }, { ...payload, g: g, arrKeys: arrKeys });
}

export const onDuplicateResourceWeb = ({ commit, state }, payload) => {
    let k;
    if (payload.item.type !== 'section') {
        k = {
            'x': payload.item.x, 'y': payload.item.y, 'w': payload.item.w, 'h': payload.item.h,
            'i': lib.guid(),
            'type': payload.item.type,
            properties: payload.item.properties
            // properties: {
            //     name: payload.item.type,
            //     style: payload.item.properties.style,
            //     elementHover: payload.item.properties.elementHover,
            //     fields: payload.item.properties.fields,
            //     map: payload.item.properties.map,
            //     text: payload.item.properties.text,
            // }
        }
        k.gridKey = payload.g;
        commit('duplicateResourceWeb', { k: k, id: payload.id })
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
            selectedIndex: payload.item.selectedIndex,
        }
        k.i = payload.g;
        let max = 0;
        let i = 0;
        state.webResources.forEach(element => {
            if (max === 0) {
                max += 1;
            }
            // if (max <= element.id) {
            //     max += element.id;
            // }
            element.selectedIndex = i;
            i++;
            if (max <= element.id) {
                max = element.id;
            }
            if (max === element.id) max += 1;
        });
        k.id = max;
        let x = 0;
        payload.item.resources.forEach(element => {
            const i = element.i;
            if (element.i !== lib.guid()) {
                k.resources.push({
                    'x': element.x, 'y': element.y, 'w': element.w, 'h': element.h, 'i': lib.guid(), 'type': element.type,
                    gridKey: payload.arrKeys[x],
                    properties: { ...element.properties }
                    // properties: {
                    //     name: element.type,
                    //     style: element.properties.style,
                    //     elementHover: element.properties.elementHover,
                    //     fields: element.properties.fields,
                    //     map: element.properties.map,
                    //     text: element.properties.text,
                    // }
                });
            }
            element.i = i;
            x++;
        });
        commit('setNewSectionWeb', k)
    }
}

export const onDuplicateResourceMobile = ({ commit, state }, payload) => {
    let k;
    if (payload.item.type !== 'section') {
        k = {
            'x': payload.item.x, 'y': payload.item.y, 'w': payload.item.w, 'h': payload.item.h,
            'i': lib.guid(),
            'type': payload.item.type,
            properties: { ...payload.item.properties }
            // properties: {
            //     name: payload.item.type,
            //     style: payload.item.properties.style,
            //     elementHover: payload.item.properties.elementHover,
            //     fields: payload.item.properties.fields,
            //     map: payload.item.properties.map,
            //     text: payload.item.properties.text,
            // }
        }
        k.gridKey = payload.g;
        commit('duplicateResourceMobile', { k: k, id: payload.id })
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
            selectedIndex: payload.item.selectedIndex,
        }
        k.i = payload.g;
        let max, i = 0;
        state.mobileResources.forEach(element => {
            if (max === 0) {
                max += 1;
            }
            // if (max <= element.id) {
            //     max += element.id;
            // }
            element.selectedIndex = i;
            i++;
            if (max <= element.id) {
                max = element.id;
            }
            if (max === element.id) max += 1;
        });
        k.id = max;
        let x = 0;
        payload.item.resources.forEach(element => {
            const i = element.i;
            if (element.i !== lib.guid()) {
                k.resources.push({
                    'x': element.x, 'y': element.y, 'w': element.w, 'h': element.h, 'i': lib.guid(), 'type': element.type,
                    gridKey: payload.arrKeys[x],
                    properties: { ...element.properties }
                    // {
                    //     name: element.type,
                    //     style: element.properties.style,
                    //     elementHover: element.properties.elementHover,
                    //     fields: element.properties.fields,
                    //     map: element.properties.map,
                    //     text: element.properties.text,
                    // }
                });
            }
            element.i = i;
            x++;
        });
        commit('setNewSectionMobile', k)
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
    addNewSectionWeb({ commit, state }, payload);
    addNewSectionMobile({ commit, state }, payload);
}

export const addNewSectionWeb = ({ commit, state }, payload) => {
    let g = lib.guid()
    let k = {
        id: state.sections.length, 'x': 0, 'y': 0, 'w': 12, 'h': 10, 'i': g, 'type': 'section', resources: [], refGridLayout: [],
        selectedIndex: payload,
        resize: {
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
    let max = 0;
    state.webResources.forEach(element => {
        if (max === 0) {
            max += 1;
        }
        // if (max <= element.id) {
        //     max += element.id;
        // }
        if (max <= element.id) {
            max = element.id;
        }
        if (max === element.id) max += 1;
    });
    k.id = max;
    commit('setNewSectionWeb', k)
}

export const addNewSectionMobile = ({ commit, state }, payload) => {
    let g = lib.guid()
    let k = {
        id: state.sections.length, 'x': 0, 'y': 0, 'w': 12, 'h': 10, 'i': g, 'type': 'section', resources: [], refGridLayout: [],
        selectedIndex: payload,
        resize: {
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
    let max = 0;
    state.mobileResources.forEach(element => {
        if (max === 0) {
            max += 1;
        }
        // if (max <= element.id) {
        //     max += element.id;
        // }
        if (max <= element.id) {
            max = element.id;
        }
        if (max === element.id) max += 1;
    });
    k.id = max;
    commit('setNewSectionMobile', k)
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
            text: 'Write your text here',
            image: null,
            hideFormName: true,
            selectedLinkTo: null,
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
            text: 'Write your text here',
            image: null,
            hideFormName: true,
            selectedLinkTo: null,
        }
    }
    console.log(k)
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

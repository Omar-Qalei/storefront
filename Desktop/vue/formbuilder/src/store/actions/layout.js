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

export const onHistoryPages = ({ commit }, payload) => {
    // payload.forEach(element => {
    //     sections.push({
    //         id: element.id, 'x': element.x, 'y': element.y, 'w': element.w, 'h': element.h, 'i': element.i, moved: false,
    //         type: element.type,
    //         resources: [], refGridLayout: element.refGridLayout, selectedIndex: element.selectedIndex, resize: {
    //             status: element.resize.status,
    //             h: element.resize.h,
    //         },
    //         collides: true,
    //         properties: { ...element.properties },
    //     });
    //     element.resources.forEach(object => {
    //         sections.forEach(obj => {
    //             obj.resources.push({
    //                 'x': object.x, 'y': object.y, 'w': object.w, 'h': object.h, moved: false,
    //                 'i': object.i,
    //                 'type': object.type,
    //                 properties: { ...object.properties },
    //                 gridKey: object.gridKey
    //             });
    //         })
    //     });
    // });

    // payload.forEach(element => {
    //     console.log();
    // });
    commit('setHistoryPages', payload)
    // commit('setWebHistoryPage', payload)
}

export const onUndoPage = ({ commit }) => {
    commit('setUndoPage')
}

export const onRedoPage = ({ commit }) => {
    commit('setRedoPage')
}

export const onSaveHistoryLayout = ({ commit }, payload) => {
    commit('saveHistoryLayout', payload)
}
export const setDrawer = (state) => {
    state.drawer = !state.drawer;
}

export const setDrawerPages = (state, payload) => {
    state.drawerPages = typeof payload === 'boolean' ? state.drawerPages = payload : !state.drawerPages;
}

export const setPages = (state, payload) => {
    state.pages = payload;
}

export const setSelectedPage = (state, payload) => {
    state.selectedPage = payload;
}

export const setLoadingPage = (state, payload) => {
    state.loading = payload;
    // state.historyList.length = 1;
    // state.undoRedo = state.historyList.length - 1;
    // state.redoStatus = true;
}

export const setHistoryPages = (state, payload) => {
    state.historyList.push(payload);

    // state.historyList.forEach(element => {
    //     element.forEach(obj => obj.resources.forEach(as => console.log('x:', as.x, 'y:', as.y)))
    // });
    // state.undoRedo = state.historyList.length - 1;
    // state.undoStatus = false;
    // state.redoStatus = false;
    console.log(state.historyList)
    state.undoRedo = state.historyList.length - 1;
    // Object.seal(state.webResources)
    if (state.historyList.length - 1 > 0) {
        state.undoStatus = false;
        state.redoStatus = true;
    }
}

export const setUndoPage = (state) => {

    // console.log('undoRedo', state.undoRedo, state.historyList[state.undoRedo])
    // if (state.undoRedo > 0) {
    //     state.undoRedo = state.undoRedo - 1;
    // }
    if (state.undoRedo > 0) state.undoRedo -= 1;
    // console.log(state.historyList.length)
    if (state.undoRedo < 0) return;
    if (state.undoRedo <= 0) state.undoStatus = true;
    if (state.historyList.length) state.redoStatus = false;
    // const type = state.historyList[state.undoRedo].type;
    const page = JSON.stringify(state.historyList[state.undoRedo][state.screenSize.screen]);
    const sections = JSON.parse(page);
    // state.webResources = sections;
    // state.sections = state.webResources;
    state.sections = sections;
    // console.log(state.historyList, state.undoRedo)
    // state.sections = state.historyList[state.undoRedo];
}

export const setRedoPage = (state) => {
    // 1 ---> after get Section reloaded
    // if (state.redo === 0) state.redo = state.historyList.length;

    // console.log('undoRedo', state.undoRedo, state.historyList[state.undoRedo])
    // if (state.undoRedo < state.historyList) {
    //     state.undoRedo = state.undoRedo + 1;
    // }
    if (state.historyList.length - 1 >= state.undoRedo) state.undoRedo += 1;
    // console.log(state.historyList.length)
    if (state.historyList.length - 1 <= state.undoRedo) { state.redoStatus = true; state.undoStatus = false }
    // if (state.undoRedo < state.mobileHistory.length - 1) state.undoStatus = false;
    // state.undoStatus = true;

    // if (state.redo !== state.undo + 1 && state.undo > 1) {
    //     state.redo = state.undo + 1;
    // }
    // if (state.redo > 1 && state.redo < state.historyList.length) {
    //     state.undo = state.undo + 1;
    //     state.redo = state.undo + 1;
    // }


    // if (state.redo < state.historyList.length && state.redo - 1 === state.undo) {
    //     state.redo += 1;
    //     state.undo = state.redo - 1;
    // }

    // if (state.redo === null) state.redo = state.historyList.length;

    // if (state.redo !== null) state.redo -= 1;

    // if (state.undo !== null) { state.redo = state.undo - 1; state.undo = state.undo + 1 }

    // if (state.redo === state.historyList.length) return;

    // state.historyWeb = payload;

    // console.log('undoRedo: ', state.undoRedo, 'undoStatus: ', state.undoStatus, 'redoStatus: ', state.redoStatus);
    console.log('undoRedo: ', state.undoRedo, state.historyList);
    // console.log('undoRedo', state.historyList[1][0].resources[0])
    // state.sections = state.historyList[state.undoRedo];
    // state.mobileResources = state.mobileHistory[state.undoRedo];
    // const type = state.historyList[state.undoRedo].type;
    const page = JSON.stringify(state.historyList[state.undoRedo][state.screenSize.screen]);
    const sections = JSON.parse(page);
    // state.webResources = sections;
    // state.sections = state.webResources;
    state.sections = sections;
}

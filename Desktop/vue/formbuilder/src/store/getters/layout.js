export const getDrawer = (state) => {
    return state.drawer
};

export const getDrawerPages = (state) => {
    return state.drawerPages
};

export const getPages = (state) => {
    return state.pages
};

export const getSelectedPage = (state) => {
    return state.selectedPage
};

export const getLoadingPage = (state) => {
    return state.loading
};

export const getWebHistoryPage = (state) => {
    return state.webHistory
};

export const getMobileHistoryPage = (state) => {
    return state.mobileHistory
};

export const getUndoPage = (state) => {
    return state.undoRedo
};

export const getRedoPage = (state) => {
    return state.undoRedo
};

export const getUndoStatus = (state) => {
    return state.undoStatus
};

export const getRedoStatus = (state) => {
    return state.redoStatus
};
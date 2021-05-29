export const getSections = (state) => {
    return state.sections
};

export const getResources = (state) => {
    return state.resources
};

export const getMouseMoveOut = (state) => {
    return state.mouseMovedOut
};

export const getRefs = (state) => {
    return state.refs
};

export const getPreventCollision = (state) => {
    return state.preventCollision
};


export const getCurrentSectionLayout = (state) => {
    return state.currentSectionLayout
};

export const getResizeSectionStatus = (state) => {
    return state.resizeSection
};

export const getScreenSize = (state) => {
    return state.screenSize
};

export const getIsResizeable = (state) => {
    return state.isResizeable
};

export const getIsAutoResize = (state) => {
    return state.isAutoResize;
};

export const getAllowSorting = (state) => {
    return state.allowSorting
};
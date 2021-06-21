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
}
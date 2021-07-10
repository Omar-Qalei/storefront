export const setShowSnackbar = (state, payload) => {
    state.snackbar = payload || null
};

export const setShowMenu = (state) => {
    state.showMenu = !state.showMenu;
};

export const setDataMenu = (state, payload) => {
    state.dataMenu = payload;
};
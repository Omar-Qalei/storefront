export const setSelectedWidgetById = (state, payload) => {
    state.selectedWidget = payload;
    console.log(state.selectedWidget);
}
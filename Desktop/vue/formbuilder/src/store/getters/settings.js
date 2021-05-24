export const getSelectedWidgetById = (state) => {
    return state.selectedWidget
};

export const getFormFields = (state) => {
    return state.selectedWidget.fields
};
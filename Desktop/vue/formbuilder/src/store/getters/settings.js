export const getSelectedWidgetById = (state) => {
    return state.selectedWidget
};

export const getFormFields = (state) => {
    return state.selectedWidget.fields
};

export const getShowChooseFilesDialog = (state) => {
    return state.showChooseFilesDialog
};

export const getTypeChooseFileDialog = (state) => {
    return state.typeChooseFileDialog
};
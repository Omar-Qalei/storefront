export const setSelectedWidgetById = (state, payload) => {
    console.log(payload);
    state.selectedWidget = payload;
}

export const setAddFormField = (state, payload) => {
    state.fields.push(payload);
    const index = state.sections[state.currentSelectedSectionIndex].resources.findIndex(element => element.id === state.selectedWidget.id);
    state.sections[state.currentSelectedSectionIndex].resources[index].properties.fields = state.fields;
}

export const setRemoveFormField = (state, payload) => {
    state.fields.fieldsList.splice(payload, 1);
}
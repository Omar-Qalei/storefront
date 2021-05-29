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

export const setTextHeight = (state) => {
    if (state.selectedWidget.type === 'text') {
        state.textHeight = document.getElementById(state.selectedWidget.i).scrollHeight;
        document.getElementById(state.selectedWidget.i).style.height = state.textHeight + "px";
        let h = state.textHeight / 30;
        h = Math.ceil(h);
        if (h % 2 !== 0) {
            h = h + 1;
        }

        // state.selectedWidget.h = h;
        if (state.selectedWidget.h < h) {
            state.selectedWidget.h = h;
        }
        // if(state.selectedWidget.h > h) {
        //     state.selectedWidget.h = state.selectedWidget.h;
        // }
    }
}

export const setRemoveBreakLines = (state) => {
    if (state.selectedWidget.type === 'text') {
        state.textHeight = document.getElementById(state.selectedWidget.i).scrollHeight;
        let h = state.textHeight / 30;
        h = Math.ceil(h);
        if (h % 2 !== 0) {
            h = h + 1;
        }
        if (state.selectedWidget.h < h) {
            state.selectedWidget.h = h;
        }
        state.textHeight = state.textHeight / state.selectedWidget.h;
        document.getElementById(state.selectedWidget.i).style.height = state.textHeight + "px";
        // if (state.getSelectedWidgetById.type === 'text') {
        // document.getElementById("text").style.height = height + "px";
        if (state.selectedWidget.properties.name && state.selectedWidget.properties.type === 'text') {
            // let value = state.selectedWidget.properties.name;
            state.selectedWidget.properties.name = state.selectedWidget.properties.name.replace(/(\r\n|\n|\r)/gm, "");
            // console.log((value.match(/\n/g) || []).length);
        }
        // state.getSelectedWidgetById.properties.name.replace(/(\r\n|\n|\r)/gm, "");
        // }
    }
}

export const checkGridHeight = (state) => {
    if (state.selectedWidget.type === 'text') {
        state.textHeight = document.getElementById(state.selectedWidget.i).scrollHeight;
        let h = state.textHeight / 30;
        h = Math.ceil(h);
        if (h % 2 !== 0) {
            h = h + 1;
        }
        if (state.selectedWidget.h < h) {
            state.selectedWidget.h = h;
        }
    }
}
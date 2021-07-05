import * as lib from '../lib';
import { SiteService } from "../../services/site/site";

export const setSiteId = (state, payload) => {
    state.siteId = payload || null
};

export const setPageId = (state, payload) => {
    state.pageId = payload || null
};

export const setCols = (state, payload) => {
    state.cols = payload || null
};

export const setSections = (state, sections) => {
    state.sections = sections || {}
};

export const setWebResources = (state, resources) => {
    state.webResources = resources || {}
};

export const setMobileResources = (state, resources) => {
    state.mobileResources = resources || {}
};

export const setResources = (state, resources) => {
    state.resources = resources || {}
};

export const duplicateResourceWeb = (state, payload) => {
    let index = state.webResources.findIndex(obj => obj.id === payload.id);
    state.selectedWidget = { i: null };
    if (state.screenSize.screen === 'web') {
        let k = {
            'x': payload.k.x, 'y': payload.k.y, 'w': payload.k.w, 'h': payload.k.h, 'i': lib.guid(), 'type': payload.k.type,
            properties: {
                name: payload.k.type,
                style: null,
                elementHover: null,
                fields: [],
                map: null,
                text: 'Write your text here'
            },
            gridKey: payload.k.i,
        }
        state.webResources[index].resources.push(k)
    }
    if (state.screenSize.screen === 'mobile') {
        state.webResources[index].resources.push(payload.k)
    }
    // state.webResources[index].resources.push(payload.k);
    SiteService.addSitePageResourceWeb(
        state.siteId,
        state.pageId,
        JSON.stringify(state.webResources)
    )
        .then((result) => {
            console.log("Web remove resources posted", result);
        })
        .catch((error) => {
            console.log(error);
        });
};

export const duplicateResourceMobile = (state, payload) => {
    let index = state.mobileResources.findIndex(obj => obj.id === payload.id);
    state.selectedWidget = { i: null };
    if (state.screenSize.screen === 'web') {
        let k = {
            'x': payload.k.x, 'y': payload.k.y, 'w': payload.k.w, 'h': payload.k.h, 'i': lib.guid(), 'type': payload.k.type,
            properties: {
                name: payload.k.type,
                style: null,
                elementHover: null,
                fields: [],
                map: null,
                text: 'Write your text here'
            },
            gridKey: payload.k.i,
        }
        state.mobileResources[index].resources.push(k)
    }
    if (state.screenSize.screen === 'mobile') {
        // state.mobileResources = state.mobileResources;
        state.webResources[index].resources.push(payload.k)
    }
    // state.mobileResources[index].resources.push(payload.k);
    SiteService.addSitePageResourceMobile(
        state.siteId,
        state.pageId,
        JSON.stringify(state.mobileResources)
    )
        .then((result) => {
            console.log("Mobile remove resources posted", result);
        })
        .catch((error) => {
            console.log(error);
        });
};

export const removeResource = (state, payload) => {
    state.selectedWidget = { i: null };
    let refIndex = state.properties.refGridLayout.$children.findIndex(element => element.i === payload.i);
    let refMobileGrid = state.properties.refGridLayout.$children.findIndex(element => element.i === payload.gridKey);
    const index = state.sections.findIndex((item) => item.id === payload.id);
    if (refIndex > -1 && index > -1) {
        state.properties.refGridLayout.$children[refIndex].$refs.item.style.transition = "none";
        state.webResources[index].resources.splice(refIndex, 1);
        state.mobileResources[index].resources.splice(refMobileGrid, 1);
        console.log('webResources', state.webResources)
        console.log('mobileResources', state.mobileResources)
    }
    SiteService.addSitePageResourceWeb(
        state.siteId,
        state.pageId,
        JSON.stringify(state.webResources)
    )
        .then((result) => {
            console.log("Web remove resources posted", result);
        })
        .catch((error) => {
            console.log(error);
        });
    SiteService.addSitePageResourceMobile(
        state.siteId,
        state.pageId,
        JSON.stringify(state.mobileResources)
    )
        .then((result) => {
            console.log("Mobile remove resources posted", result);
        })
        .catch((error) => {
            console.log(error);
        });
};

export const removeSection = (state, payload) => {
    if (payload.id !== 0) {
        const indexWeb = state.webResources.map((item) => item.id).indexOf(payload.id);
        const indexMobile = state.webResources.map((item) => item.id).indexOf(payload.id);
        state.webResources.splice(indexWeb, 1);
        state.mobileResources.splice(indexMobile, 1);
    }
    SiteService.addSitePageResourceWeb(
        state.siteId,
        state.pageId,
        JSON.stringify(state.webResources)
    )
        .then((result) => {
            console.log("Web remove section posted", result);
        })
        .catch((error) => {
            console.log(error);
        });
    SiteService.addSitePageResourceMobile(
        state.siteId,
        state.pageId,
        JSON.stringify(state.mobileResources)
    )
        .then((result) => {
            console.log("Mobile remove section posted", result);
        })
        .catch((error) => {
            console.log(error);
        });
}

export const setPages = (state, pages) => {
    state.pages = pages || [];
}

// // Mutation too new grid item in resources
export const setNewSection = (state, payload) => {
    let previousIndex = 0, nextIndex = 0;
    if (payload.selectedIndex !== undefined) {
        previousIndex = payload.selectedIndex;
    }
    if (state.sections[payload.selectedIndex + 1] !== undefined) {
        nextIndex = state.sections[payload.selectedIndex + 1].selectedIndex;
    }
    // Push between Indexes
    if (previousIndex > 0 && nextIndex !== 0) {
        console.log('test1')
        payload.selectedIndex = nextIndex;
        console.log(payload.selectedIndex);
        payload.y = nextIndex * state.sectionProperties.default;
        const array = state.sections.splice(nextIndex, state.sections.length, payload);
        console.log('array', array)
        // const arrayWeb = state.webResources.splice(nextIndex, state.sections.length, payload);
        // const arrayMobile = state.mobileResources.splice(nextIndex, state.sections.length, payload);
        state.sections.join();
        array.forEach(item => {
            if (item.id !== state.sections[previousIndex].id && payload.id !== item.id) {
                //    if (previousIndex < item.selectedIndex) {
                if (item.id !== 0) {
                    item.selectedIndex += 1;
                    item.y *= state.sectionProperties.default;
                    item.resize.h = item.y;
                }
                //    }
            }
        });
        state.sections.push(...array);
        // if (state.screenSize.screen === 'web') {
        //     state.mobileResources.push(...array);
        // }
        // if (state.screenSize.screen === 'mobile') {
        //     state.webResources.push(...array);
        // }
        // state.webResources.push(...array);
        // state.mobileResources.push(...array);
        // if (state.screenSize.screen === 'mobile') {
        //     state.webResources.push(...arrayWeb);
        //     state.mobileResources = state.sections;
        // }
        // if (state.screenSize.screen === 'web') {
        //     state.mobileResources.push(...arrayMobile);
        //     state.webResources = state.sections;
        // }
    }

    // Push After Index bigger than index = 0
    if (previousIndex > 0 && nextIndex === 0) {
        console.log('test2')
        payload.y = (previousIndex + 1) * state.sectionProperties.default;
        payload.selectedIndex = previousIndex + 1;
        console.log(previousIndex + 2, state.sections.length);
        const array = state.sections.splice(previousIndex + 1, state.sections.length, payload);
        console.log(array, state.sections)
        // const arrayWeb = state.webResources.splice(previousIndex + 2, state.sections.length, payload);
        // const arrayMobile = state.mobileResources.splice(previousIndex + 2, state.sections.length, payload);
        state.sections.join();
        console.log('previousIndex', previousIndex, nextIndex, state.sections, array)
        array.forEach(item => {
            // if (nextIndex < item.selectedIndex) {
            item.selectedIndex += 1;
            item.y *= state.sectionProperties.default;
            item.resize.h = item.y;
            // }
        });
        state.sections.push(...array);
        // if (state.screenSize.screen === 'web') {
        //     state.mobileResources.push(...array);
        // }
        // if (state.screenSize.screen === 'mobile') {
        //     state.webResources.push(...array);
        // }
        // state.webResources.push(...array);
        // state.mobileResources.push(...array);
    }

    // Push After index = 0 
    if (previousIndex === 0 && nextIndex !== 0) {
        console.log('test3')
        payload.selectedIndex = nextIndex;
        payload.y = state.sectionProperties.default;
        let array = state.sections.splice(nextIndex, state.sections.length, payload);
        // let arrayWeb = state.webResources.splice(nextIndex, state.sections.length, payload);
        // let arrayMobile = state.mobileResources.splice(nextIndex, state.sections.length, payload);
        state.sections.join();
        array.forEach(item => {
            console.log('item', item);
            // if (nextIndex < item.selectedIndex) {
            item.selectedIndex += 1;
            item.y *= state.sectionProperties.default;
            item.resize.h = item.y;
            // }
        });
        state.sections.push(...array);
        // if (state.screenSize.screen === 'web') {
        //     state.mobileResources.push(...array);
        // }
        // if (state.screenSize.screen === 'mobile') {
        //     state.webResources.push(...array);
        // }
        // state.webResources.push(...array);
        // state.mobileResources.push(...array);
    }

    // // By Default First Push 
    if (!previousIndex && nextIndex === 0) {
        console.log('test4')
        payload.selectedIndex = 1;
        state.sections.push(payload);
        if (state.screenSize.screen === 'web') {
            state.mobileResources.push(payload);
        }
        if (state.screenSize.screen === 'mobile') {
            state.webResources.push(payload);
        }
    }
    if (state.screenSize.screen === 'web') {
        // state.webResources = state.sections;
    }
    if (state.screenSize.screen === 'mobile') {
        state.mobileResources = state.sections;
    }
    state.sections = compact(state.sections);

    // state.sections.forEach(element => console.log(element.id + '====>' + element.selectedIndex));
}

// Mutation too new grid item in resources
export const setNewSectionMobile = (state, payload) => {
    let previousIndex = 0, nextIndex = 0;
    if (payload.selectedIndex !== undefined) {
        previousIndex = payload.selectedIndex;
    }
    if (state.mobileResources[payload.selectedIndex + 1] !== undefined) {
        nextIndex = state.mobileResources[payload.selectedIndex + 1].selectedIndex;
    }
    // Push between Indexes
    if (previousIndex > 0 && nextIndex !== 0) {
        console.log('test1')
        payload.selectedIndex = nextIndex;
        payload.y = nextIndex * state.sectionProperties.default;
        const array = state.mobileResources.splice(nextIndex, state.mobileResources.length, payload);
        state.mobileResources.join();
        array.forEach(item => {
            if (item.id !== state.mobileResources[previousIndex].id && payload.id !== item.id) {
                //    if (previousIndex < item.selectedIndex) {
                if (item.id !== 0) {
                    item.selectedIndex += 1;
                    item.y *= state.sectionProperties.default;
                    item.resize.h = item.y;
                }
                //    }
            }
        });
        state.mobileResources.push(...array);
    }

    // Push After Index bigger than index = 0
    if (previousIndex > 0 && nextIndex === 0) {
        console.log('test2')
        payload.y = (previousIndex + 1) * state.sectionProperties.default;
        payload.selectedIndex = previousIndex + 1;
        const array = state.mobileResources.splice(previousIndex + 1, state.mobileResources.length, payload);
        state.mobileResources.join();
        array.forEach(item => {
            // if (nextIndex < item.selectedIndex) {
            item.selectedIndex += 1;
            item.y *= state.sectionProperties.default;
            item.resize.h = item.y;
            // }
        });
        state.mobileResources.push(...array);
    }

    // Push After index = 0 
    if (previousIndex === 0 && nextIndex !== 0) {
        console.log('test3')
        payload.selectedIndex = nextIndex;
        payload.y = state.sectionProperties.default;
        let array = state.mobileResources.splice(nextIndex, state.mobileResources.length, payload);
        state.mobileResources.join();
        array.forEach(item => {
            // if (nextIndex < item.selectedIndex) {
            item.selectedIndex += 1;
            item.y *= state.sectionProperties.default;
            item.resize.h = item.y;
            // }
        });
        state.mobileResources.push(...array);
    }

    // // By Default First Push 
    if (!previousIndex && nextIndex === 0) {
        console.log('test4')
        payload.selectedIndex = 1;
        state.mobileResources.push(payload);
    }
    state.mobileResources = compact(state.mobileResources);
    // state.mobileResources.forEach(element => console.log(element.id + '====>' + element.selectedIndex));
    SiteService.addSitePageResourceMobile(
        state.siteId,
        state.pageId,
        JSON.stringify(state.mobileResources)
    )
        .then((result) => {
            console.log("Mobile remove section posted", result);
        })
        .catch((error) => {
            console.log(error);
        });
}

// Mutation too new grid item in resources
export const setNewSectionWeb = (state, payload) => {
    let previousIndex = 0, nextIndex = 0;
    if (payload.selectedIndex !== undefined) {
        previousIndex = payload.selectedIndex;
    }
    if (state.webResources[payload.selectedIndex + 1] !== undefined) {
        nextIndex = state.webResources[payload.selectedIndex + 1].selectedIndex;
    }
    // Push between Indexes
    if (previousIndex > 0 && nextIndex !== 0) {
        console.log('test1')
        payload.selectedIndex = nextIndex;
        payload.y = nextIndex * state.sectionProperties.default;
        const array = state.webResources.splice(nextIndex, state.webResources.length, payload);
        state.webResources.join();
        array.forEach(item => {
            if (item.id !== state.webResources[previousIndex].id && payload.id !== item.id) {
                //    if (previousIndex < item.selectedIndex) {
                if (item.id !== 0) {
                    item.selectedIndex += 1;
                    item.y *= state.sectionProperties.default;
                    item.resize.h = item.y;
                }
                //    }
            }
        });
        state.webResources.push(...array);
    }

    // Push After Index bigger than index = 0
    if (previousIndex > 0 && nextIndex === 0) {
        console.log('test2')
        payload.y = (previousIndex + 1) * state.sectionProperties.default;
        payload.selectedIndex = previousIndex + 1;
        const array = state.webResources.splice(previousIndex + 1, state.webResources.length, payload);
        // const arrayWeb = state.webResources.splice(previousIndex + 2, state.webResources.length, payload);
        // const arrayMobile = state.webResources.splice(previousIndex + 2, state.webResources.length, payload);
        state.webResources.join();
        console.log('previousIndex', previousIndex, nextIndex, state.webResources, array)
        array.forEach(item => {
            // if (nextIndex < item.selectedIndex) {
            item.selectedIndex += 1;
            item.y *= state.sectionProperties.default;
            item.resize.h = item.y;
            // }
        });
        state.webResources.push(...array);
    }

    // Push After index = 0 
    if (previousIndex === 0 && nextIndex !== 0) {
        console.log('test3')
        payload.selectedIndex = nextIndex;
        payload.y = state.sectionProperties.default;
        let array = state.webResources.splice(nextIndex, state.webResources.length, payload);
        state.webResources.join();
        array.forEach(item => {
            console.log('item', item);
            // if (nextIndex < item.selectedIndex) {
            item.selectedIndex += 1;
            item.y *= state.sectionProperties.default;
            item.resize.h = item.y;
            // }
        });
        state.webResources.push(...array);
    }

    // // By Default First Push 
    if (!previousIndex && nextIndex === 0) {
        console.log('test4')
        payload.selectedIndex = 1;
        state.webResources.push(payload);
    }
    state.webResources = compact(state.webResources);
    // state.webResources.forEach(element => console.log(element.id + '====>' + element.selectedIndex));
    SiteService.addSitePageResourceWeb(
        state.siteId,
        state.pageId,
        JSON.stringify(state.webResources)
    )
        .then((result) => {
            console.log("Web remove resources posted", result);
        })
        .catch((error) => {
            console.log(error);
        });
}


// Mutation too set layout grid item in resources
export const setLayout = (state, payload) => {
    state.properties = payload;
}

export const setElement = (state, payload) => {
    state.element = payload;
}

export const setMoveElement = (state, payload) => {
    state.moveElement = payload;
}

// Mutation too drag over grid item in resources
export const setDragOver = (state, payload) => {
    state.mouseXY.x = payload.x;
    state.mouseXY.y = payload.y;
}

// Mutation too drag grid item in resources
export const setDrag = (state, payload) => {
    let indexSection;
    state.isAutoResize = false;
    if (state.indexSection !== null && state.selectedGridId !== null) {
        indexSection = state.indexSection;
        // prevent change height Section on draging
        if (state.selectedPerviousGridId && state.selectedPerviousGridId === state.selectedGridId) {
            let parentRect = document
                .getElementById(state.selectedGridId)
                .getBoundingClientRect();
            let mouseInGrid = false;
            let el = null, new_pos = null;
            if (
                state.mouseXY.x > parentRect.left &&
                state.mouseXY.x < parentRect.right &&
                state.mouseXY.y > parentRect.top &&
                state.mouseXY.y < parentRect.bottom
            ) {
                mouseInGrid = true;
                state.preventCollision = true;
            }
            if (
                mouseInGrid === true &&
                state.sections[indexSection].resources.findIndex((item) => item.i === "drop") === -1
            ) {
                // for set inside section
                if (state.currentSelectedSectionIndex === indexSection) {
                    state.sections[indexSection].resources.push(payload);
                }
            }
            let index, elementHight, elementWidth;
            index = state.sections[indexSection].resources.findIndex((item) => item.i === "drop");
            if (index !== -1) {
                // if (state.properties.refGridLayout !== null && state.properties.refGridLayout.$children.length > 0) {
                elementHight = state.sections[indexSection].resources[index].h;
                elementWidth = state.sections[indexSection].resources[index].w;
                if (state.properties.refGridLayout) {
                    if (state.properties.refGridLayout.$children[index] !== undefined) {
                        el = state.properties.refGridLayout.$children[index];
                        el.dragging = {
                            top: state.mouseXY.y - parentRect.top,
                            left: state.mouseXY.x - parentRect.left,
                        };
                        new_pos = el.calcXY(
                            state.mouseXY.y - parentRect.top,
                            state.mouseXY.x - parentRect.left
                        );
                        if (mouseInGrid === true) {
                            state.properties.refGridLayout.dragEvent(
                                "dragstart",
                                "drop",
                                new_pos.x,
                                new_pos.y,
                                elementWidth,
                                elementHight
                            );
                            state.dragPos.i = String(index);
                            state.dragPos.x = new_pos.x !== null ? new_pos.x : 0;
                            state.dragPos.y = new_pos.y !== null ? new_pos.y : 0;
                        }
                    }

                }
                if (mouseInGrid === false) {
                    state.properties.refGridLayout.dragEvent(
                        "dragend",
                        "drop",
                        new_pos.x,
                        new_pos.y,
                        elementWidth,
                        elementHight
                    );
                    state.properties.refGridLayout.$children = state.properties.refGridLayout.$children.filter((obj) => obj.i !== "drop");
                    state.sections[indexSection].resources = state.sections[indexSection].resources.filter((obj) => obj.i !== "drop");
                }
            }
        } else {
            const indexSection = state.sections.findIndex(item => item.i === state.selectedPerviousGridId);
            console.log('interupt', state.refs, state.selectedPerviousGridId, state.sections);
            if (indexSection && indexSection > -1) {
                if (state.refs[indexSection].$children[0].$children.length > 0) {
                    state.refs[indexSection].$children[0].$children[0].$children = state.refs[indexSection].$children[0].$children[0].$children.filter((obj) => obj.i !== 'drop');
                }
                if (state.sections[indexSection].resources.length > 0) {
                    state.sections[indexSection].resources = state.sections[indexSection].resources.filter((obj) => obj.i !== "drop");
                }
            }
        }
        state.selectedPerviousGridId = state.selectedGridId;
    }
}

// Mutation too drag end grid item in resources
export const setDragEnd = (state, payload) => {
    state.preventCollision = false;
    console.log(state.dragPos.x, state.dragPos.y)
    if (state.indexSection !== null && state.selectedGridId) {
        if (state.selectedPerviousGridId && state.selectedPerviousGridId === state.selectedGridId) {
            let mouseInGrid = false;
            let indexSection = state.indexSection;
            let gridId = state.selectedGridId;
            let parentRect = document
                .getElementById(gridId)
                .getBoundingClientRect();
            if (
                state.mouseXY.x > parentRect.left &&
                state.mouseXY.x < parentRect.right &&
                state.mouseXY.y > parentRect.top &&
                state.mouseXY.y < parentRect.bottom
            ) {
                mouseInGrid = true;
            }
            if (mouseInGrid === true) {
                state.properties.refGridLayout.dragEvent(
                    "dragend",
                    "drop",
                    state.dragPos.x,
                    state.dragPos.y,
                    3,
                    2
                );
                // state.sections[indexSection].resources = state.sections[indexSection].resources.filter((obj) => obj.i !== "drop");
                // state.sections[indexSection].resources.push(payload);
                state.sections[indexSection].resources = state.sections[indexSection].resources.filter((obj) => obj.i !== "drop");
                payload.gridKey = payload.i;
                state.sections[indexSection].resources.push(payload);
                if (state.screenSize.screen === 'web') {
                    state.webResources = state.sections;
                    let k = {
                        'x': 0, 'y': 0, 'w': state.element.width, 'h': state.element.height, 'i': lib.guid(), 'type': state.element.type,
                        properties: {
                            name: state.element.type,
                            style: null,
                            elementHover: null,
                            fields: [],
                            map: null,
                            text: 'Write your text here'
                        },
                        gridKey: payload.i,
                    }
                    state.mobileResources[indexSection].resources.push(k)
                }
                if (state.screenSize.screen === 'mobile') {
                    state.mobileResources = state.sections;
                    let k = {
                        'x': 0, 'y': 0, 'w': state.element.width, 'h': state.element.height, 'i': lib.guid(), 'type': state.element.type,
                        properties: {
                            name: state.element.type,
                            style: null,
                            elementHover: null,
                            fields: [],
                            map: null,
                            text: 'Write your text here'
                        },
                        gridKey: payload.i,
                    }
                    state.webResources[indexSection].resources.push(k)
                }
                let addNewRows = (payload.h + payload.y) - state.sections[indexSection].h;
                state.sections[indexSection].h = (payload.h + payload.y) > state.sections[indexSection].h ? state.sections[indexSection].h + addNewRows : state.sections[indexSection].h;
                state.sections = compact(state.sections);
                state.properties.refGridLayout.dragEvent('dragend', state.dragPos.i, state.dragPos.x, state.dragPos.y, 1, 1);
                try {
                    state.properties.refGridLayout.$children[state.sections[indexSection].resources.length].$refs.item.style.display = "block";
                    state.indexSection = null;
                    state.selectedGridId = null;
                } catch {
                    console.log()
                }
                state.indexSection = null;
                state.selectedGridId = null;
                SiteService.addSitePageResourceWeb(
                    state.siteId,
                    state.pageId,
                    JSON.stringify(state.webResources)
                )
                    .then((result) => {
                        console.log("Web posted", result);
                    })
                    .catch((error) => {
                        console.log(error);
                    });
                SiteService.addSitePageResourceMobile(
                    state.siteId,
                    state.pageId,
                    JSON.stringify(state.mobileResources)
                )
                    .then((result) => {
                        console.log("Mobile posted", result);
                    })
                    .catch((error) => {
                        console.log(error);
                    });
            }
        }
        else {
            console.log('interupt', state.refs);
            const indexSection = state.sections.findIndex(item => item.i === state.selectedPerviousGridId);
            if (indexSection > -1) {
                if (state.refs[indexSection].$children[0].$children.length > 0) {
                    state.refs[indexSection].$children[0].$children[0].$children = state.refs[indexSection].$children[0].$children[0].$children.filter((obj) => obj.i !== 'drop');
                }
                state.sections.forEach(element => element.resources = element.resources.filter((obj) => obj.i !== "drop"));
            }
        }
        state.selectedPerviousGridId = state.selectedGridId;
    }
    state.sections.forEach(element => element.resources = element.resources.filter((obj) => obj.i !== "drop"));
}

export const setMouseTouched = (state, payload) => {
    let indexSection = payload.indexSection;
    let gridId = payload.i;
    state.indexSection = indexSection;
    state.selectedGridId = gridId;
    state.currentSelectedSectionId = payload.id;
}

export const setUpdateRefs = (state, payload) => {
    state.refs = payload;
}

export const setUpdateSectionLayout = (state, payload) => {
    // state.currentSelectedSectionId !== null ? state.currentSelectedSectionId : 
    let sectionId = payload.sectionId;
    let gridHeight = payload.h;

    let statusCompact = false;
    if (!state.preventCollision)
        if (sectionId !== undefined) {
            let selectedIndex = state.sections.find((element) => element.id === sectionId).selectedIndex;
            let currentIndex = state.sections.findIndex((element) => element.selectedIndex === selectedIndex);
            if (state.sections[currentIndex].resize.h < gridHeight) {
                statusCompact = true;
                state.sections[currentIndex].h = gridHeight;
                if (statusCompact) {
                    state.sections = compact(state.sections);
                    statusCompact = false;
                }
            }
        }
}

export const setSelectedSection = (state, payload) => {
    state.currentSelectedSectionIndex = payload.index;
    state.currentSelectedSectionId = payload.id;
}

export const setResizeSection = (state, payload) => {
    state.resizeSection = payload;
}

export const setSortSectionsLayout = (state) => {
    let sectionId = 0;
    let statusCompact = false;
    if (sectionId !== undefined) {
        let currentIndex = state.sections.find((element) => element.id === sectionId).selectedIndex;
        let maxGridHeight = 0;
        state.sections[currentIndex].resources.map(element => {
            if ((element.y + element.h) > maxGridHeight) {
                maxGridHeight = element.y + element.h;
            }
        });
        if (state.sections[currentIndex].h < maxGridHeight) {
            state.sections[currentIndex].h = maxGridHeight;
            if (statusCompact) {
                state.sections = compact(state.sections);
                statusCompact = false;
            }
        }
    }
}

// Action for check update section height on resize
export const checkUpdateSectionLayoutResized = (state, payload) => {
    const sectionId = payload.sectionId;
    if (sectionId !== undefined) {
        let selectedIndex = state.sections.find((element) => element.id === sectionId).selectedIndex;
        let currentIndex = state.sections.findIndex((element) => element.selectedIndex === selectedIndex);
        let maxGridHeight = 0;
        state.sections[currentIndex].resources.map(element => {
            if ((element.y + element.h) > maxGridHeight) {
                maxGridHeight = element.y + element.h;
            }
        });
        if (state.sections[currentIndex].h <= maxGridHeight) {
            state.sections[currentIndex].resize.h = maxGridHeight;
            state.sections[currentIndex].h = maxGridHeight;
            state.sections = compact(state.sections);
        }
    }
}

// Action for update section height on resize
export const setUpdateSectionLayoutResized = (state, payload) => {
    const sectionId = payload.sectionId;
    if (sectionId !== undefined) {
        let currentIndex = state.sections.find((element) => element.id === sectionId).selectedIndex;
        state.sections[currentIndex].resize.status = true;
        let maxGridHeight = 0;
        state.sections[currentIndex].resources.map(element => {
            if ((element.y + element.h) > maxGridHeight) {
                maxGridHeight = element.y + element.h;
            }
        });
        if (payload.h > maxGridHeight) {
            state.isResizeable = true;
            state.sections[currentIndex].resize.h = payload.h;
        }
        if (payload.h <= maxGridHeight) {
            state.isResizeable = false;
            state.sections[currentIndex].resize.h = maxGridHeight;
        }
        if (payload.h < state.sectionProperties.minH) {
            state.isResizeable = false;
            state.sections[currentIndex].resize.h = state.sectionProperties.minH;
        }
    }
}

export const setUpdateSectionLayoutGridResized = (state, payload) => {
    state.resizedSection = payload;
}

export const setResizeSectionScreen = (state, payload) => {
    state.screenSize = payload;
}

export const rearrangementResources = (state) => {
    state.sections.map(element => {
        if (element.collides)
            element.resources = compactResources(element.resources);

        element.collides = true;
    });
    state.mobileResources.map(element => {
        if (element.collides)
            element.resources = compactResources(element.resources);

        element.collides = true;
    });
    state.sections = compact(state.sections);
    setSortSectionsLayout(state)
}

//-------------------------------------------------------------------------------------------------------------------------------//
//------------------------------------------------------------Helpers Sections------------------------------------------------------------//
//-------------------------------------------------------------------------------------------------------------------------------//
export function getAllCollisions(layout, layoutItem) {
    return layout.filter((l) => collides(l, layoutItem));
}

export function getLayoutItem(layout, id) {
    for (let i = 0, len = layout.length; i < len; i++) {
        if (layout[i].i === id) return layout[i];
    }
}

export function collides(l1, l2) {
    if (l1 === l2) return false; // same element
    if (l1.x + l1.w <= l2.x) return false; // l1 is left of l2
    if (l1.x >= l2.x + l2.w) return false; // l1 is right of l2
    if (l1.y + l1.h <= l2.y) return false; // l1 is above l2
    if (l1.y >= l2.y + l2.h) return false; // l1 is below l2

    // If want to margin between element set true
    return true;
}

// Overlap  ++ 
export function compact(layout) {

    // Statics go in the compareWith array right away so items flow around them.
    // const compareWith = getStatics(layout);
    // We go through the items by row and column.
    const sorted = sortLayoutItemsByRowCol(layout);
    // Holding for new items.
    const out = Array(layout.length);

    for (let i = 0, len = sorted.length; i < len; i++) {
        let l = sorted[i];
        // Don't move static elements
        // if (!l.static) {
        //     l = compactItem(compareWith, l);

        //     // Add to comparison array. We only collide with items before this one.
        //     // Statics are already in this array.
        //     // compareWith.push(l);
        // }
        // Add to output array to make sure they still come out in the right order.
        out[layout.indexOf(l)] = l;

        // Clear moved flag, if it exists.
        l.moved = false;
    }
    return out;
}

export function compactResources(layout) {

    // Statics go in the compareWith array right away so items flow around them.
    // const compareWith = getStatics(layout);
    // We go through the items by row and column.
    const sorted = sortLayoutItemsByRowCol(layout);
    // Holding for new items.
    const out = Array(layout.length);

    for (let i = 0, len = sorted.length; i < len; i++) {
        let l = sorted[i];
        // Don't move static elements
        // if (!l.static) {
        l = compactItem(layout, l);

        // Add to comparison array. We only collide with items before this one.
        // Statics are already in this array.
        // compareWith.push(l);
        // }
        // Add to output array to make sure they still come out in the right order.
        out[layout.indexOf(l)] = l;

        // Clear moved flag, if it exists.
        // l.moved = false;
    }
    return out;
}
// /**
//  * Compact an item in the layout. Overlap
//  */
export function compactItem(compareWith, l) {
    //   if (verticalCompact) {
    //     // Move the element up as far as it can go without colliding.
    // console.log('compactItem:', !getFirstCollision(compareWith, l), compareWith.type, l.type);
    while (l.y > 0 && !getFirstCollision(compareWith, l)) {
        l.y--;
    }
    //   }
    // Move it down, and keep moving it down if it's colliding.
    let collides;
    while ((collides = getFirstCollision(compareWith, l))) {
        l.y = collides.y + collides.h;
    }
    return l;
}
export function getFirstCollision(layout, layoutItem) {
    // console.log('getFirstCollision:', layout, layoutItem.type);
    for (let i = 0, len = layout.length; i < len; i++) {
        if (collides(layout[i], layoutItem)) return layout[i];
    }
}

export function sortLayoutItemsByRowCol(layout) {
    return [].concat(layout).sort(function (a, b) {
        if (a.y === b.y && a.x === b.x) {
            return 0;
        }

        if (a.y > b.y || (a.y === b.y && a.x > b.x)) {
            return 1;
        }

        return -1;
    });
}

export function getStatics(layout) {
    //return [];
    return layout.filter((l) => l.static);
}
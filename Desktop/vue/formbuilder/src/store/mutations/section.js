export const setSections = (state, sections) => {
    state.sections = sections || {}
};

export const setResources = (state, resources) => {
    state.resources = resources || {}
};

// Mutation too new grid item in resources
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
        payload.y = nextIndex * state.sectionProperties.default;
        const array = state.sections.splice(nextIndex, state.sections.length, payload);
        state.sections.join();
        array.forEach(item => {
            if (item.id !== state.sections[previousIndex].id && payload.id !== item.id) {
                //    if (previousIndex < item.selectedIndex) {
                if (item.id !== 0) {
                    item.selectedIndex += 1;
                    item.y *= state.sectionProperties.default;
                }
                //    }
            }
        });
        state.sections.push(...array);
    }

    // Push After Index bigger than index = 0
    if (previousIndex > 0 && nextIndex === 0) {
        console.log('test2')
        payload.y = (previousIndex + 1) * state.sectionProperties.default;
        payload.selectedIndex = previousIndex + 1;
        const array = state.sections.splice(previousIndex + 2, state.sections.length, payload);
        state.sections.join();
        array.forEach(item => {
            // if (item.id !== state.sections[previousIndex].id && payload.id !== item.id) {
            //    if (nextIndex < item.selectedIndex) {
            item.selectedIndex += 1;
            item.y *= state.sectionProperties.default;
            //    }
            // }
        });
        state.sections.push(...array);
    }

    // Push After index = 0 
    if (previousIndex === 0 && nextIndex !== 0) {
        console.log('test3')
        payload.selectedIndex = nextIndex;
        payload.y = state.sectionProperties.default;
        const array = state.sections.splice(nextIndex, state.sections.length, payload);
        state.sections.join();
        array.forEach(item => {
            // if (nextIndex < item.selectedIndex) {
            item.selectedIndex += 1;
            item.y *= state.sectionProperties.default;
            // }
        });
        state.sections.push(...array);
    }

    // // By Default First Push 
    if (!previousIndex && nextIndex === 0) {
        console.log('test4')
        payload.selectedIndex = 1;
        state.sections.push(payload);
    }
    state.sections = compact(state.sections);
    // state.sections.forEach(element => console.log(element.id + '====>' + element.selectedIndex));
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
                try {
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
                        state.dragPos.x = new_pos.x;
                        state.dragPos.y = new_pos.y;
                    }
                    if (mouseInGrid === false) {
                        state.refs[indexSection].$children[0].$children[0].dragEvent(
                            "dragend",
                            "drop",
                            new_pos.x,
                            new_pos.y,
                            elementWidth,
                            elementHight
                        );
                        state.refs[indexSection].$children[0].$children[0].$children = state.refs[indexSection].$children[0].$children[0].$children.filter((obj) => obj.i !== "drop");
                        state.sections[indexSection].resources = state.sections[indexSection].resources.filter((obj) => obj.i !== "drop");
                    }
                } catch {
                    console.log();
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
                state.sections[indexSection].resources = state.sections[indexSection].resources.filter((obj) => obj.i !== "drop");
                // UNCOMMENT below if you want to add a grid-item
                // if (state.currentSelectedSectionIndex === indexSection) {
                state.sections[indexSection].resources.push(payload);
                let addNewRows = (payload.h + payload.y) - state.sections[indexSection].h;
                state.sections[indexSection].h = (payload.h + payload.y) > state.sections[indexSection].h ? state.sections[indexSection].h + addNewRows : state.sections[indexSection].h;
                state.sections = compact(state.sections);
                state.properties.refGridLayout.dragEvent('dragend', state.dragPos.i, state.dragPos.x, state.dragPos.y, 1, 1);
                // }
                // state.sections[state.currentSelectedSectionIndex].resources.push(payload);
                // }
                try {
                    state.properties.refGridLayout.$children[state.sections[indexSection].resources.length].$refs.item.style.display = "block";
                    state.indexSection = null;
                    state.selectedGridId = null;
                } catch {
                    console.log()
                }
                state.indexSection = null;
                state.selectedGridId = null;
            }
        }
        else {
            console.log('interupt', state.refs);
            const indexSection = state.sections.findIndex(item => item.i === state.selectedPerviousGridId);
            if (indexSection > -1) {
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
    let sectionId = state.currentSelectedSectionId ? state.currentSelectedSectionId : payload.sectionId;
    let gridHeight = payload.sectionH;
    if (sectionId !== undefined) {
        let currentIndex = state.sections.find((element) => element.id === sectionId).selectedIndex;
        if (state.sections[currentIndex].resize.h < gridHeight) {
            state.sections[currentIndex].h = gridHeight;
            state.sections = compact(state.sections);
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
        if (payload.h <= maxGridHeight) {
            state.isResizeable = false;
            state.sections[currentIndex].resize.h = maxGridHeight;
        }
        if (payload.h > maxGridHeight) {
            state.isResizeable = true;
            state.sections[currentIndex].resize.h = payload.h;
        }
        if (payload.h <= state.sectionProperties.minH) {
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

//-------------------------------------------------------------------------------------------------------------------------------//
//------------------------------------------------------------Helpers------------------------------------------------------------//
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
    const compareWith = getStatics(layout);
    // We go through the items by row and column.
    const sorted = sortLayoutItemsByRowCol(layout);
    // Holding for new items.
    const out = Array(layout.length);

    for (let i = 0, len = sorted.length; i < len; i++) {
        let l = sorted[i];
        // Don't move static elements
        if (!l.static) {
            l = compactItem(compareWith, l);

            // Add to comparison array. We only collide with items before this one.
            // Statics are already in this array.
            // compareWith.push(l);
        }
        // Add to output array to make sure they still come out in the right order.
        out[layout.indexOf(l)] = l;

        // Clear moved flag, if it exists.
        l.moved = false;
    }
    return out;
}

// /**
//  * Compact an item in the layout. Overlap
//  */
export function compactItem(compareWith, l) {
    //   if (verticalCompact) {
    //     // Move the element up as far as it can go without colliding.
    //     while (l.y > 0 && !getFirstCollision(compareWith, l)) {
    //       l.y--;
    //     }
    //   }
    // Move it down, and keep moving it down if it's colliding.
    let collides;
    while ((collides = getFirstCollision(compareWith, l))) {
        l.y = collides.y + collides.h;
    }
    return l;
}
export function getFirstCollision(layout, layoutItem) {
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

export const setDrawer = (state) => {
   state.drawer = !state.drawer;
}

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
      payload.y = nextIndex * 10;
      const array = state.sections.splice(nextIndex, state.sections.length, payload);
      state.sections.join();
      array.forEach(item => {
         if (item.id !== state.sections[previousIndex].id && payload.id !== item.id) {
            //    if (previousIndex < item.selectedIndex) {
            if (item.id !== 0) {
               item.selectedIndex += 1;
               item.y *= 10;
            }
            //    }
         }
      });
      state.sections.push(...array);
   }

   // Push After Index bigger than index = 0
   if (previousIndex > 0 && nextIndex === 0) {
      console.log('test2')
      payload.y = (previousIndex + 1) * 10;
      payload.selectedIndex = previousIndex + 1;
      const array = state.sections.splice(previousIndex + 2, state.sections.length, payload);
      state.sections.join();
      array.forEach(item => {
         // if (item.id !== state.sections[previousIndex].id && payload.id !== item.id) {
         //    if (nextIndex < item.selectedIndex) {
         item.selectedIndex += 1;
         item.y *= 10;
         //    }
         // }
      });
      state.sections.push(...array);
   }

   // Push After index = 0 
   if (previousIndex === 0 && nextIndex !== 0) {
      console.log('test3')
      payload.selectedIndex = nextIndex;
      payload.y = 10;
      const array = state.sections.splice(nextIndex, state.sections.length, payload);
      state.sections.join();
      array.forEach(item => {
         // if (nextIndex < item.selectedIndex) {
         item.selectedIndex += 1;
         item.y *= 10;
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
   if (state.indexSection !== null && state.selectedGridId !== null) {
      indexSection = state.indexSection;
      if (state.selectedPerviousGridId && state.selectedPerviousGridId === state.selectedGridId) {
         let parentRect = document
            .getElementById(state.selectedGridId)
            .getBoundingClientRect();
         let mouseInGrid = false;
         state.elementPosition = false;
         let el = null, new_pos = null;
         //  + state.elementSizePx.h
         if (
            state.mouseXY.x > parentRect.left &&
            state.mouseXY.x < parentRect.right &&
            state.mouseXY.y > parentRect.top &&
            state.mouseXY.y < parentRect.bottom
         ) {
            mouseInGrid = true;
            state.preventCollision = true;
            state.elementPosition = true;
         } else {
            // state.indexSection = null;
            // state.selectedGridId = null;
            // state.properties.refGridLayout.$children = state.properties.refGridLayout.$children.filter((obj) => obj.i !== "drop");
            // state.sections[indexSection].resources = state.sections[indexSection].resources.filter((obj) => obj.i !== "drop");
            // indexSection = null;
            // gridId = null;
         }
         if (
            mouseInGrid === true &&
            state.sections[indexSection].resources.findIndex((item) => item.i === "drop") === -1 &&
            state.selectedSection === indexSection
         ) {
            state.sections[state.selectedSection].resources.push(payload);
            state.sections[state.selectedSection].h += payload.h;
         }
         let index, elementHight, elementWidth;
         // if (indexSection !== null && gridId !== null) {
         index = state.sections[indexSection].resources.findIndex((item) => item.i === "drop");
         // } else {
         //    index = -1;
         // }
         if (index !== -1) {
            // try {
            //    state.properties.refGridLayout.$children[
            //       state.sections[indexSection].resources.length
            //    ].$refs.item.style.display = "none";
            // } catch {
            //    console.log();
            // }
            // if (state.properties.refGridLayout !== null && state.properties.refGridLayout.$children.length > 0) {
            elementHight = state.sections[indexSection].resources[index].h;
            elementWidth = state.sections[indexSection].resources[index].w;
            try {
               el = state.refs[state.selectedSection].$children[0].$children[0].$children[index];
               el.dragging = {
                  top: state.mouseXY.y - parentRect.top,
                  left: state.mouseXY.x - parentRect.left,
               };
               new_pos = el.calcXY(
                  state.mouseXY.y - parentRect.top,
                  state.mouseXY.x - parentRect.left
               );
               if (mouseInGrid === true) {
                  state.refs[state.selectedSection].$children[0].$children[0].dragEvent(
                     "dragstart",
                     "drop",
                     new_pos.x,
                     new_pos.y,
                     elementWidth,
                     elementHight
                  );
                  state.dragPos.i = String(index);
                  state.dragPos.x = state.sections[indexSection].resources[index].x;
                  state.dragPos.y = state.sections[indexSection].resources[index].y;
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
            // }
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
         //  + state.elementSizePx.h
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
            if (state.selectedSection === indexSection) {
               state.sections[state.selectedSection].resources.push(payload);
            }
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
         }
      }
      else {
         console.log('interupt', state.refs);
         const indexSection = state.sections.findIndex(item => item.i === state.selectedPerviousGridId);
         console.log(indexSection)
         if (indexSection > -1) {
            if (state.refs[indexSection].$children[0].$children.length > 0) {
               state.refs[indexSection].$children[0].$children[0].$children = state.refs[indexSection].$children[0].$children[0].$children.filter((obj) => obj.i !== 'drop');
            }
            if (state.sections[indexSection].resources.length > 0) {
               state.sections[indexSection].resources = state.sections[indexSection].resources.filter((obj) => obj.i !== "drop");
            }
         }
      }
      state.elementPosition = false;
      state.selectedPerviousGridId = state.selectedGridId;
   }
}

export const setMouseTouched = (state, payload) => {
   let indexSection = payload.indexSection;
   let gridId = payload.i;
   state.indexSection = indexSection;
   state.selectedGridId = gridId;
}

export const removedDuplicated = (state, payload) => {
   state.refs = payload;
   // let i = 0;
   // if (state.sections.length > 0 && state.selectedGridId !== undefined) {
   //    const indexSection = state.sections.findIndex(item => item.i === state.selectedPerviousGridId);
   //    if (state.selectedPerviousGridId && state.selectedPerviousGridId !== state.selectedGridId) {
   //       if (payload[indexSection].$children[0].$children.length > 0) {
   //           payload[indexSection].$children[0].$children[0].$children = payload[i].$children[0].$children[0].$children.filter((obj) => obj.i !== 'drop' && obj.i !== -1);
   //       }
   //       // if (state.sections[indexSection].resources.length > 0) {
   //       //    state.sections[indexSection].resources = state.sections[indexSection].resources.filter((obj) => obj.i !== "drop");
   //       // }
   //    }
   // }
}

export const setUpdateSectionLayout = (state, payload) => {
   let sectionId = payload.sectionId;
   let gridHeight = payload.sectionH;
   // const margin = payload.margin;
   // let calcMargin = Math.ceil((margin[0] + margin[1]) / 100);
   // const sectionHeight = payload.layoutH + calcMargin + (gridHeight / 2);
   let currentIndex = null;
   let selectedSectionY = 0;
   state.currentSectionLayout = state.currentSectionLayout ? state.currentSectionLayout : 10;
   state.sections.forEach((item) => {
      if (item.id === sectionId) {
         currentIndex = item.selectedIndex;
         // if (sectionHeight === 8) {
         //    item.h = 12 + gridHeight;
         // }
         // if (sectionHeight < 8) {
         //    item.h = 10 + gridHeight;
         // }
         // if (sectionHeight > 8) {
         //    item.h = sectionHeight + 4 + gridHeight;
         // }
         // if (item.h < gridHeight) {
         selectedSectionY = item.h;
         item.h = gridHeight;
         state.currentSectionLayout = gridHeight
         // }
      }
      // 
      if (currentIndex !== null && item.selectedIndex > currentIndex) {
         // section height - item position
         // let layout = sectionHeight - item.h;
         let layout = selectedSectionY - item.h;
         if (layout > 0 && selectedSectionY !== gridHeight) {
            item.y += layout;
            console.log(item.y)
         }
         if (gridHeight > item.y) {
            item.y += gridHeight;
         }
      }
   });
}

export const setElementSizePx = (state, payload) => {
   state.elementSizePx = payload;
}

export const setSelectedSection = (state, payload) => {
   state.selectedSection = payload;
}
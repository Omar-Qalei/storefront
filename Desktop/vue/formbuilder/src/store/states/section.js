export default {
    sections: {},
    resources: {},
    mouseXY: { x: null, y: null },
    dragPos: { x: null, y: null, w: 1, h: 1, i: null },
    properties: { refGridLayout: null, colNum: 0 },
    element: {},
    moveElement: false, // for dragover between sidebar and current section
    indexSection: null,
    selectedPerviousGridId: null, // for vertify if I select same section to stop loop darg or end drag
    selectedGridId: null, // for vertify if I select a new or same section to stop loop darg or end drag
    refs: [], // all refs for sections
    preventCollision: false, // don't move element if I darg a new element or move it
    currentSelectedSectionId: null, // for vertify if current equal selected Section by id
    currentSelectedSectionIndex: null, // for vertify if current equal selected Section by index
    resizeSection: false, // stop resize section from drag
    screenSize: { width: '100%', cols: 12 },
    isResizeable: false, // for resize sections
    isAutoResize: true, // prevent change height Section on draging
    allowSorting: true,
    sectionProperties: {
        default: 10, // defalut add a new section
        minH: 2 // min height for  section
    }
}

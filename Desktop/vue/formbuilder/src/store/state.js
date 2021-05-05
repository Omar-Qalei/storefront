export default {
    drawer: true,
    sections: {},
    resources: {},
    mouseXY: { x: null, y: null },
    dragPos: { x: null, y: null, w: 1, h: 1, i: null },
    properties: { refGridLayout: null, colNum: 0 },
    element: {},
    moveElement: false,
    indexSection: null,
    selectedPerviousGridId: null,
    selectedGridId: null,
    refs: [],
    preventCollision: false,
    elementPosition: false,
    elementSizePx: {
        w: 0,
        h: 0
    },
    currentSectionLayout: null,
    selectedSection: null
}
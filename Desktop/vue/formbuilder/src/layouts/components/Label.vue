<template>
  <div
    class="widget-element"
    @drag="onDrag"
    @dragend="onDragend"
    @mouseup="onMoveElement(true)"
    @mousedown="onMoveElement(false);onSetElement(element);"
    draggable="true"
    unselectable="on"
    ref="label"
  >
    Label
  </div>
</template>

<script>
import { mapActions } from "vuex";
export default {
  name: "Label",
  data() {
    return {
      element: {
        type: "label",
        width: 2,
        height: 2,
      },
    };
  },
  mounted() {
    const thiz = this;
    document.addEventListener(
      "dragover",
      function(e) {
        const data = {
          x: e.clientX,
          y: e.clientY,
        };
        thiz.onDragOver(data);
      },
      false
    );
  },
  methods: {
    ...mapActions([
      "onDrag",
      "onDragend",
      "onDragOver",
      "onSetElement",
      "onMoveElement",
    ]),
  },
};
</script>

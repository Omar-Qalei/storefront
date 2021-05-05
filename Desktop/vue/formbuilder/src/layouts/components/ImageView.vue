<template>
  <div
    class="widget-element"
    @drag="onDrag"
    @dragend="onDragend"
    @mouseup="onMoveElement(true)"
    @mousedown="onMoveElement(false);onSetElement(element);"
    draggable="true"
    unselectable="on"
    ref="image"
  >
    Image
  </div>
</template>

<script>
import { mapActions } from "vuex";
export default {
  name: "ImageView",
  data() {
    return {
      element: {
        type: "image",
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

<template>
  <div
    @drag="onDrag"
    @dragend="onDragend"
    @mouseup="onMoveElement(true)"
    @mousedown="
      onMoveElement(false);
      onSetElement(element);
    "
    draggable="true"
    unselectable="on"
    ref="text"
  >
    <div class="widget-element">
      <v-icon>mdi-format-text</v-icon>
    </div>
    <v-flex class="text-center widget-element-text">Text</v-flex>
  </div>
</template>

<script>
import { mapActions } from "vuex";
export default {
  name: "TextView",
  data() {
    return {
      element: {
        type: "text",
        width: 6,
        height: 8,
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

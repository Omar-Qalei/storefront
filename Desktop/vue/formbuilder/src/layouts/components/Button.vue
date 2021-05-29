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
    ref="button"
  >
    <div class="widget-element">
      <v-icon>mdi-gesture-tap-button</v-icon>
    </div>
    <v-flex class="text-center widget-element-text">Button</v-flex>
  </div>
</template>

<script>
import { mapActions } from "vuex";
export default {
  name: "Button",
  data() {
    return {
      element: {
        type: "button",
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

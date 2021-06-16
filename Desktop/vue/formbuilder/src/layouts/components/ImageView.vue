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
    ref="image"
  >
    <div class="widget-element">
      <v-icon>mdi-image</v-icon>
    </div>
    <v-flex class="text-center widget-element-text">Image</v-flex>
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
        width: 3,
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

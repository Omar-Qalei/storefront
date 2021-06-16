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
    ref="video"
  >
    <div class="widget-element">
      <v-icon>mdi-youtube</v-icon>
    </div>
    <v-flex class="text-center widget-element-text">Video</v-flex>
  </div>
</template>

<script>
import { mapActions } from "vuex";
export default {
  name: "Video",
  data() {
    return {
      element: {
        type: "video",
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

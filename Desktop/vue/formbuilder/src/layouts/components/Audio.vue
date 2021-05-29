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
    ref="audio"
  >
    <div class="widget-element">
      <v-icon>mdi-volume-medium</v-icon>
    </div>
    <v-flex class="text-center widget-element-text">Audio</v-flex>
  </div>
</template>

<script>
import { mapActions } from "vuex";
export default {
  name: "Audio",
  data() {
    return {
      element: {
        type: "audio",
        width: 4,
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

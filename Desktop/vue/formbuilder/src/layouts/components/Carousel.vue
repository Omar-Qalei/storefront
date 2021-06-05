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
    ref="carousel"
  >
    <div class="widget-element">
      <v-icon>mdi-view-carousel</v-icon>
    </div>
    <v-flex class="text-center widget-element-text">Slider</v-flex>
  </div>
</template>

<script>
import { mapActions } from "vuex";
export default {
  name: "Carousel",
  data() {
    return {
      element: {
        type: "carousel",
        width: 8,
        height: 16,
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

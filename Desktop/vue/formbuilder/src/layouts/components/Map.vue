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
    ref="map"
  >
    <div class="widget-element">
      <v-icon>mdi-map</v-icon>
    </div>
    <v-flex class="text-center widget-element-text">Map</v-flex>
  </div>
</template>

<script>
import { mapActions } from "vuex";
export default {
  name: "Map",
  data() {
    return {
      element: {
        type: "map",
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

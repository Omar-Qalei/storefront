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
    ref="form"
  >
    <div class="widget-element">
      <v-icon>mdi-form-select</v-icon>
    </div>
    <v-flex class="text-center widget-element-text">Form</v-flex>
  </div>
</template>

<script>
import { mapActions } from "vuex";
export default {
  name: "Form",
  data() {
    return {
      element: {
        type: "form",
        width: 4,
        height: 12,
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

<template>
  <div class="widget">
    <SettingsWidget :show="showSettings" />
    <v-btn class="draggable" draggable="true" unselectable="on">
      Button
    </v-btn>
  </div>
</template>

<script>
import SettingsWidget from "./SettingsWidget";
export default {
  name: "ButtonWidget",
  components: {
    SettingsWidget,
  },
  data() {
    return {
      // height: Number,
      // width: Number,
    };
  },
  props: {
    showSettings: Boolean,
  },
};
</script>

<style scoped>
.vue-grid-item:not(.vue-grid-placeholder) {
  background: #ccc;
  border: 1px solid black;
}
.vue-grid-item .resizing {
  opacity: 0.9;
}
.vue-grid-item .static {
  background: #cce;
}
.v-btn {
  position: absolute !important;
  display: block !important;
  z-index: -1 !important;
  width: 100% !important;
  height: 100% !important;
}
.widget {
  position: absolute;
  width: 100%;
  height: 100%;
}
</style>

<template>
  <div class="widget">
    <SettingsWidget :show="item.i === getSelectedWidgetById.i"></SettingsWidget>
    <img src="https://i.imgur.com/x97x4tG.jpg" />
  </div>
</template>

<script>
import SettingsWidget from "../settings/SettingsWidget";
import { mapGetters } from "vuex";
export default {
  name: "ImageWidget",
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
    item: {},
  },
  computed: {
    ...mapGetters(["getSelectedWidgetById"]),
  },
  mounted() {},
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
.label {
  border: none;
  outline: none;
}
.widget,
img {
  width: 100%;
  height: 100%;
  object-fit: cover;
}
</style>

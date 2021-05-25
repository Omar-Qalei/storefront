<template>
  <div class="widget">
    <SettingsWidget :show="item.i === getSelectedWidgetById.i"></SettingsWidget>
    <iframe
      src="https://www.youtube.com/embed/y881t8ilMyc"
      frameborder="0"
      allowfullscreen
    ></iframe>
  </div>
</template>

<script>
import SettingsWidget from "../settings/SettingsWidget";
import { mapGetters } from "vuex";
export default {
  name: "VideoWidget",
  components: {
    SettingsWidget,
  },
  data() {
    return {
      items: [
        { title: "Click Me" },
        { title: "Click Me" },
        { title: "Click Me" },
        { title: "Click Me 2" },
      ],
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
iframe {
  width: 100%;
  height: 100%;
  z-index: -1;
  position: absolute;
}
.widget {
  width: 100%;
  height: 100%;
  z-index: 1;
}
</style>

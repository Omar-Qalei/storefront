<template>
  <div class="widget">
    <SettingsWidget :show="item.i === getSelectedWidgetById.i"></SettingsWidget>
    <img
      :src="getDefaultImage(item)"
      :alt="item.properties.alt"
      :style="item.properties.style"
    />
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
  methods: {
    getDefaultImage(item) {
      if (item.properties.image) return item.properties.image;
      return "https://i.imgur.com/x97x4tG.jpg";
    },
  },
  mounted() {},
};
</script>

<style scoped>
.label {
  border: none;
  outline: none;
}
.widget,
img {
  width: 100%;
  height: 100%;
  object-fit: inherit;
}
</style>

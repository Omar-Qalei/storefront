<template>
  <div class="widget">
    <SettingsWidget :show="item.i === getSelectedWidgetById.i"></SettingsWidget>
    <img
      :src="getDefaultImage(item)"
      :alt="item.properties.alt"
      :style="item.properties.style ? item.properties.style : style"
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
      style: {
        objectFit: "cover",
      },
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
      return "https://zrassets.s3.eu-north-1.amazonaws.com/bed-and-breakfast/images/amenities.jpg";
    },
  },
  created() {},
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

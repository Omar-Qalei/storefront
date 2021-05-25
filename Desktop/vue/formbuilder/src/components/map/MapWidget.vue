<template>
  <div class="widget">
    <SettingsWidget :show="item.i === getSelectedWidgetById.i"></SettingsWidget>
    <GmapMap
      :center="{ lat: 10, lng: 10 }"
      :zoom="7"
      map-type-id="terrain"
      class="map"
    >
      <template v-if="!markers.length">
        <GmapMarker
          :key="index"
          v-for="(m, index) in markers"
          :position="m.position"
          :clickable="true"
          :draggable="true"
          @click="center = m.position"
        />
      </template>
    </GmapMap>
  </div>
</template>

<script>
import SettingsWidget from "../settings/SettingsWidget";
import { mapGetters } from "vuex";
export default {
  name: "MapWidget",
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
      markers: [],
    };
  },
  computed: {
    ...mapGetters(["getSelectedWidgetById"]),
  },
  props: {
    item: {},
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
.map {
  width: 100%;
  height: 100%;
  display: block;
}
</style>

<template>
  <div class="widget">
    <SettingsWidget
      :show="item.i === getSelectedWidgetById.i"
      :item="item"
      :sectionId="sectionId"
    ></SettingsWidget>
    <GmapMap
      :center="getDefaultLocation(item)"
      :zoom="12"
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
          @click="item.properties.map = m.position"
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
  props: {
    item: {},
    sectionId: Number,
  },
  data() {
    return {
      center: { lat: 51.5167849, lng: -0.1340803 },
      currentPlace: null,
      markers: [],
      places: [],
    };
  },
  computed: {
    ...mapGetters(["getSelectedWidgetById"]),
  },
  methods: {
    getDefaultLocation(item) {
      if (item.properties.map) return item.properties.map;
      return { lat: 51.5167849, lng: -0.1340803 };
    },
  },
  mounted() {},
  updated() {
    // navigator.geolocation.getCurrentPosition((position) => {
    //   this.center = {
    //     lat: position.coords.latitude,
    //     lng: position.coords.longitude,
    //   };
    // });
  },
};
</script>

<style scoped>
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

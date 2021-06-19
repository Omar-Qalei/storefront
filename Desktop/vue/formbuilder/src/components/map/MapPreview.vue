<template>
  <div class="widget">
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
export default {
  name: "MapPreview",
  props: {
    item: {},
    sectionId: Number,
  },
  data() {
    return {
      items: [
        { title: "Click Me" },
        { title: "Click Me" },
        { title: "Click Me" },
        { title: "Click Me 2" },
      ],
      center: { lat: 51.5167849, lng: -0.1340803 },
      currentPlace: null,
      markers: [],
      places: [],
    };
  },
  methods: {
    getDefaultLocation(item) {
      if (item.properties.map) return item.properties.map;
      return { lat: 51.5167849, lng: -0.1340803 };
    },
  },
};
</script>

<style scoped>
iframe {
  width: 100%;
  height: 100%;
  z-index: 1;
  position: absolute;
}
.widget {
  width: 100%;
  height: 100%;
  z-index: 0;
}
.map {
  width: 100%;
  height: 100%;
  display: block;
}
</style>

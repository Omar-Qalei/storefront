<template>
  <v-container class="map-content" fluid>
    <v-row class="pt-4">
      <v-col cols="8">
        <h2 class="body-1 font-weight-medium mb-2">
          Address
        </h2>
        <GmapAutocomplete
          @place_changed="value = $event"
          ref="map"
          :options="{
            fields: ['geometry', 'formatted_address', 'address_components'],
          }"
          :value="selectedValue"
        />
        <!-- <v-text-field class="d-none" v-model="value"></v-text-field> -->
      </v-col>
    </v-row>
  </v-container>
</template>

<script>
import { mapGetters } from "vuex";
export default {
  name: "MapContent",
  data() {
    return {
      center: { lat: 51.5167849, lng: -0.1340803 },
      currentPlace: null,
      markers: [],
      places: [],
      value: null,
      address: "1 Rathbone Square, London W1T 1FB, UK",
    };
  },
  computed: {
    ...mapGetters(["getSelectedWidgetById"]),
    selectedValue: function() {
      if (this.value && this.value !== undefined)
        return this.value.formatted_address;
      return this.address;
    },
  },
  methods: {
    addMarker: function() {
      if (this.currentPlace) {
        // this.markers.push({ position: marker });
        // this.places.push(this.currentPlace);
        this.currentPlace = null;
      }
    },
    geolocate: function() {
      navigator.geolocation.getCurrentPosition((position) => {
        this.center = {
          lat: position.coords.latitude,
          lng: position.coords.longitude,
        };
      });
    },
  },
  mounted() {
    this.geolocate();
  },
  created() {
    if (this.getSelectedWidgetById.properties.address)
      this.address = this.getSelectedWidgetById.properties.address;
  },
  updated() {
    if (this.value.geometry) {
      const marker = {
        lat: this.value.geometry.location.lat(),
        lng: this.value.geometry.location.lng(),
      };
      console.log(marker);
      this.getSelectedWidgetById.properties.address = this.value.formatted_address;
      this.getSelectedWidgetById.properties.map = marker;
    }
  },
};
</script>

<style scoped>
input {
  min-height: 56px;
  width: 100%;
  padding: 0 12px;
  border: 1px solid rgba(0, 0, 0, 0.87);
  outline: none;
  border-radius: 4px;
}
input:focus {
  border: 2px solid #6200ea;
}
</style>

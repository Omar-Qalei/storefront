<template>
  <v-container class="video-content" fluid>
    <v-row class="pt-4">
      <v-col cols="12">
        <h2 class="body-1 font-weight-medium mb-2">
          Video URL
        </h2>
        <v-text-field
          outlined
          placeholder="https://www.youtube.com/embed/test"
          v-model="getSelectedWidgetById.properties.url"
          hide-details
        ></v-text-field>
      </v-col>
      <v-col cols="12">
        <v-switch v-model="autoPlay" label="Auto Play"></v-switch>
      </v-col>
    </v-row>
  </v-container>
</template>

<script>
import { mapGetters } from "vuex";
export default {
  name: "VideoContent",
  data() {
    return {
      autoPlay: false,
    };
  },
  computed: {
    ...mapGetters(["getSelectedWidgetById"]),
  },
  created() {
    this.getSelectedWidgetById.properties.name = "";
  },
  updated() {
    this.getSelectedWidgetById.properties.autoPlay = this.autoPlay ? 1 : 0;
  },
};
</script>

<style></style>

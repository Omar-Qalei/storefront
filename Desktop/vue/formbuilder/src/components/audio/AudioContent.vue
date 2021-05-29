<template>
  <v-container class="audio-content" fluid>
    <v-row class="pt-4">
      <v-col cols="12">
        <h2 class="body-1 font-weight-medium mb-2">
          Upload Audio
        </h2>
        <v-col cols="12" class="backgroundSection">
          <audio v-if="audio" controls>
            <source :src="audio" type="audio/mpeg" />
            <!-- <source src="myAudio.ogg" type="audio/ogg"> -->
            <p>
              Your browser doesn't support HTML5 audio. Here is a
              <a href="myAudio.mp4">link to the audio</a> instead.
            </p>
          </audio>
          <label class="labelFile" v-else>
            <input type="file" class="d-none" @change="uploadAudio($event)" />
            <h2 class="body-1 font-weight-medium">
              Add Audio
            </h2>
          </label>
        </v-col>
      </v-col>
    </v-row>
  </v-container>
</template>

<script>
import { mapGetters } from "vuex";
export default {
  name: "AudioContent",
  data() {
    return {
      text: null,
      selectedLinkTo: 0,
      selectedPage: null,
      selectedUrl: null,
      statusNewTab: false,
      audio: null,
      tags: [
        { id: 0, title: "Page" },
        { id: 1, title: "URL" },
        { id: 2, title: "Phone" },
        { id: 3, title: "Email" },
      ],
      pages: ["Home", "About", "Services"],
    };
  },
  computed: {
    ...mapGetters(["getSelectedWidgetById"]),
  },
  methods: {
    uploadAudio: function(event) {
      console.log(event);
      this.audio = "https://www.w3schools.com/html/horse.mp3";
    },
  },
  updated() {
    this.getSelectedWidgetById.properties.selectedLinkTo = this.selectedLinkTo;
    this.getSelectedWidgetById.properties.audio = this.audio;
  },
};
</script>

<style scoped>
img {
  width: 100%;
  height: 100%;
}
.backgroundSection {
  height: 150px;
  border-radius: 4px;
  border: 1px solid black;
  display: flex;
  align-items: center;
  place-content: center;
}
.labelFile {
  display: flex;
  height: 100%;
  width: 100%;
  align-items: center;
  justify-content: center;
}
</style>

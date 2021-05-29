<template>
  <div class="widget">
    <SettingsWidget :show="item.i === getSelectedWidgetById.i"></SettingsWidget>
    <audio controls>
      <source :src="getDefaultImage(item)" type="audio/mpeg" />
      <!-- <source src="myAudio.ogg" type="audio/ogg"> -->
      <p>
        Your browser doesn't support HTML5 audio. Here is a
        <a href="myAudio.mp4">link to the audio</a> instead.
      </p>
    </audio>
  </div>
</template>

<script>
import SettingsWidget from "../settings/SettingsWidget";
import { mapGetters } from "vuex";
export default {
  name: "AudioWidget",
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
      if (item.properties.audio) return item.properties.audio;
      return "https://www.w3schools.com/html/mov_bbb.mp4";
    },
  },
};
</script>

<style scoped>
.widget,
audio {
  width: 100%;
  height: 100%;
}
audio {
  width: 100%;
  height: 100%;
  position: absolute;
  z-index: -1;
}
</style>

<template>
  <div class="widget">
    <audio controls>
      <source
        src="https://www.w3schools.com/html/horse.mp3"
        type="audio/mpeg"
      />
      <!-- <source src="myAudio.ogg" type="audio/ogg"> -->
      <p>
        Your browser doesn't support HTML5 audio. Here is a
        <a href="myAudio.mp4">link to the audio</a> instead.
      </p>
    </audio>
  </div>
</template>

<script>
export default {
  name: "AudioWidget",
  data() {
    return {
      // height: Number,
      // width: Number,
    };
  },
  props: {
    refItem: null,
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

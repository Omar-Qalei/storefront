<template>
  <div class="widget">
    <iframe :src="getDefaultUrl(item)" frameborder="0" allowfullscreen></iframe>
    <!-- <iframe
      :src="getDefaultUrl(item) + item.properties.autoPlay"
      allow="autoplay"
      frameborder="0"
      allowfullscreen
    ></iframe> -->
  </div>
</template>

<script>
export default {
  name: "VideoPreview",
  data() {
    return {
      items: [
        { title: "Click Me" },
        { title: "Click Me" },
        { title: "Click Me" },
        { title: "Click Me 2" },
      ],
    };
  },
  props: {
    item: {},
    sectionId: Number,
  },
  methods: {
    getDefaultUrl: function(item) {
      // return item.properties.url + "?autoplay="
      if (item.properties.url) {
        const videoId = this.getId(item.properties.url);
        return this.convertToEmbedded(videoId);
      }
      return "https://www.youtube.com/embed/tbnzAVRZ9Xc";
    },
    convertToEmbedded: function(videoId) {
      const iframeMarkup = "https://www.youtube.com/embed/" + videoId;
      return iframeMarkup;
    },
    getId: function(url) {
      const regExp = /^.*(youtu.be\/|v\/|u\/\w\/|embed\/|watch\?v=|&v=)([^#&?]*).*/;
      const match = url.match(regExp);
      return match && match[2].length === 11 ? match[2] : null;
    },
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
}
.widget {
  width: 100%;
  height: 100%;
}
</style>

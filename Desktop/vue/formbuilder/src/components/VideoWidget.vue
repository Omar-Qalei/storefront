<template>
  <div class="widget">
    <iframe
      src="https://www.youtube.com/embed/y881t8ilMyc"
      frameborder="0"
      allowfullscreen
    ></iframe>
  </div>
</template>

<script>
export default {
  name: "VideoWidget",
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
</style>

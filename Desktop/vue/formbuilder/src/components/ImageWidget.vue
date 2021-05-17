<template>
  <div class="widget">
    <img src="https://i.imgur.com/x97x4tG.jpg" />
  </div>
</template>

<script>
export default {
  name: "ImageWidget",
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
.label {
  border: none;
  outline: none;
}
.widget,
img {
  width: 100%;
  height: 100%;
  object-fit: cover;
}
</style>

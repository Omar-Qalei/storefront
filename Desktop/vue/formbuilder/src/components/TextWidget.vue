<template>
  <div class="widget">
    <input class="label" value="Write here something..." />
  </div>
</template>

<script>
export default {
  name: "TextWidget",
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
.widget {
  /* position: absolute; */
  width: 100%;
  height: 100%;
}
</style>

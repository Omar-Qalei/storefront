<template>
  <div class="widget">
    <img
      :src="getDefaultImage(item)"
      :alt="item.properties.alt"
      :style="item.properties.style ? item.properties.style : style"
    />
  </div>
</template>

<script>
export default {
  name: "ImagePreview",
  data() {
    return {
      style: {
        objectFit: "cover",
      },
    };
  },
  props: {
    item: {},
    sectionId: Number,
  },
  methods: {
    getDefaultImage(item) {
      if (item.properties.image) return item.properties.image;
      return "https://zrassets.s3.eu-north-1.amazonaws.com/bed-and-breakfast/images/amenities.jpg";
    },
  },
};
</script>

<style scoped>
.label {
  border: none;
  outline: none;
}
.widget,
img {
  width: 100%;
  height: 100%;
  object-fit: inherit;
}
</style>

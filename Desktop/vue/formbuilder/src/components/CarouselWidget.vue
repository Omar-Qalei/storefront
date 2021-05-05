<template>
  <div class="widget">
    <v-carousel v-model="model">
    <v-carousel-item
      v-for="(color, i) in colors"
      :key="color"
    >
      <v-sheet
        :color="color"
        height="100%"
        tile
      >
        <v-row
          class="fill-height"
          align="center"
          justify="center"
        >
          <div class="display-3">
            Slide {{ i + 1 }}
          </div>
        </v-row>
      </v-sheet>
    </v-carousel-item>
  </v-carousel>
  </div>
</template>

<script>

export default {
  name: "CarouselWidget",
  data() {
    return {
     model: 0,
      colors: [
        'primary',
        'secondary',
        'yellow darken-2',
        'red',
        'orange',
      ],
    };
  },
  props: {
    refItem: null,
  },
  mounted() {
  },
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
.v-carousel {
  position: absolute !important;
  display: block !important;
  z-index: -1 !important;
  width: 100% !important;
  height: 100% !important;
}
.widget {
  position: absolute;
  width: 100%;
  height: 100%;
}
</style>

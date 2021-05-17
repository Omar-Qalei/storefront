<template>
  <transition name="fadeInDown" v-if="show">
    <div class="widget">
      <v-btn class="mr-2" color="white" fab x-small light>
        <v-icon>mdi-cog</v-icon>
      </v-btn>
      <v-btn class="mr-2" color="white" fab x-small light>
        <v-icon>mdi-content-duplicate</v-icon>
      </v-btn>
      <v-btn color="red" fab x-small dark>
        <v-icon>mdi-trash-can</v-icon>
      </v-btn>
    </div>
  </transition>
</template>

<script>
export default {
  name: "SettingsWidget",
  data() {
    return {
      // height: Number,
      // width: Number,
    };
  },
  props: {
    show: Boolean,
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
.widget {
  position: absolute;
  top: -40px;
}
</style>

<template>
  <div class="widget" v-show="show">
    <!-- Setting Button + Dialog -->
    <v-btn
      class="mr-2"
      color="white"
      fab
      x-small
      light
      @click="$modal.show('settings')"
    >
      <v-icon>mdi-cog</v-icon>
    </v-btn>
    <!-- Setting Button + Dialog -->
    <v-btn class="mr-2" color="white" fab x-small light>
      <v-icon>mdi-content-duplicate</v-icon>
    </v-btn>
    <v-btn color="red" fab x-small dark>
      <v-icon>mdi-trash-can</v-icon>
    </v-btn>
  </div>
  <!-- </transition> -->
</template>

<script>
export default {
  name: "SettingsWidget",
  props: {
    show: Boolean,
  },
  data() {
    return {
      dialog: false,
      // height: Number,
      // width: Number,
    };
  },
  methods: {},
};
</script>

<style scoped>
.widget {
  position: absolute;
  top: -40px;
}
</style>

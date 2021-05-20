<template>
  <v-menu
    v-model="color"
    :close-on-content-click="false"
    :nudge-width="200"
    offset-x
    left
  >
    <template v-slot:activator="{ on, attrs }">
      <v-avatar
        :color="currentColor ? currentColor.hexa : 'accent'"
        v-bind="attrs"
        v-on="on"
        size="25"
        @click="color = !color"
      ></v-avatar>
    </template>
    <v-card>
      <v-card-text>
        <v-color-picker
          v-model="currentColor"
          dot-size="25"
          swatches-max-height="200"
        ></v-color-picker>
      </v-card-text>
    </v-card>
  </v-menu>
</template>

<script>
export default {
  name: "ColorPickerWidget",
  data() {
    return {
      // height: Number,
      // width: Number,
      currentColor: null,
      color: false,
    };
  },
  props: {
    type: null,
  },
  watch: {
    currentColor: function(value) {
      switch (this.type) {
        case "element":
          this.$emit("colorElement", value.hexa);
          break;

        case "hover":
          this.$emit("colorElementHover", value.hexa);
          break;
      }
    },
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

<template>
  <v-menu
    v-model="isColored"
    :close-on-content-click="false"
    :nudge-width="200"
    offset-x
    left
  >
    <template v-slot:activator="{ on, attrs }">
      <v-avatar
        :color="currentColor ? currentColor : color"
        v-bind="attrs"
        v-on="on"
        size="25"
        @click="isColored = !isColored"
        class="elevation-2"
        ><v-icon>mdi-palette</v-icon></v-avatar
      >
    </template>
    <v-card>
      <v-card-text>
        <v-color-picker
          v-model="currentColor"
          dot-size="10"
          mode="hexa"
          swatches-max-height="200"
          value="hexa"
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
      currentColor: null,
      isColored: false,
    };
  },
  props: {
    type: null,
    color: null,
  },
  watch: {
    currentColor: function(value) {
      switch (this.type) {
        case "element":
          this.$emit("colorElement", value);
          break;

        case "hover":
          this.$emit("colorElementHover", value);
          break;
      }
    },
  },
  created() {
    if (this.color) this.currentColor = this.color;
  },
};
</script>

<style scoped>
.widget {
  position: absolute;
  width: 100%;
  height: 100%;
}
.v-menu {
  z-index: 999;
}
</style>

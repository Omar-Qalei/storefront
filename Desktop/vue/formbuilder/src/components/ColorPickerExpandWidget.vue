<template>
  <v-color-picker
    dot-size="10"
    mode="hexa"
    flat
    :swatches="swatches"
    show-swatches
    swatches-max-height="200"
    :width.sync="width"
    value="hexa"
    v-model="currentColor"
  ></v-color-picker>
</template>

<script>
export default {
  name: "ColorPickerExpandWidget",
  data() {
    return {
      currentColor: "#FF0000",
      isColored: false,
      swatches: [
        ["#FF0000", "#AA0000", "#550000"],
        ["#FFFF00", "#AAAA00", "#555500"],
        ["#00FF00", "#00AA00", "#005500"],
        ["#00FFFF", "#00AAAA", "#005555"],
        ["#0000FF", "#0000AA", "#000055"],
      ],
    };
  },
  props: {
    type: null,
    color: null,
    width: Number,
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
  destroyed() {
    this.currentColor = null;
  },
};
</script>

<style scoped>
.border {
  border: 1px solid black;
  height: 32px;
  min-width: 32px;
  width: 32px;
  display: flex;
  justify-content: center;
  align-items: center;
  border-radius: 50%;
}
.widget {
  position: absolute;
  width: 100%;
  height: 100%;
}
.v-menu {
  z-index: 999;
}
</style>

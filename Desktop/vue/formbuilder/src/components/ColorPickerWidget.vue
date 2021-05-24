<template>
  <v-menu
    v-model="isColored"
    :close-on-content-click="false"
    :nudge-width="200"
    offset-x
    left
  >
    <template v-slot:activator="{ on, attrs }">
      <div class="border">
        <v-avatar
          :color="currentColor ? currentColor.hexa : color"
          v-bind="attrs"
          v-on="on"
          size="18"
          @click="isColored = !isColored"
          class="border"
        ></v-avatar>
      </div>
    </template>
    <v-card>
      <v-card-text>
        <v-color-picker
          v-model="currentColor"
          dot-size="10"
          mode="hexa"
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
          this.$emit("colorElement", value.hexa);
          break;

        case "hover":
          this.$emit("colorElementHover", value.hexa);
          break;
      }
    },
  },
  created() {
    console.log(this.currentColor);
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

<template>
  <div class="widget" @mouseover="hover = true" @mouseleave="hover = false">
    <SettingsWidget :show="item.i === getSelectedWidgetById.i"></SettingsWidget>
    <div
      class="d-flex"
      :style="[item.properties.style, onHover(item.properties.elementHover)]"
    >
      <v-flex
        :style="[item.properties.style, onHover(item.properties.elementHover)]"
      >
        <input class="label" :value="item.properties.name" />
      </v-flex>
    </div>
  </div>
</template>

<script>
import SettingsWidget from "../settings/SettingsWidget";
import { mapGetters } from "vuex";
export default {
  name: "TextWidget",
  components: {
    SettingsWidget,
  },
  data() {
    return {
      hover: false,
    };
  },
  props: {
    item: {},
  },
  computed: {
    ...mapGetters(["getSelectedWidgetById"]),
  },
  methods: {
    onHover: function(elementHover) {
      if (this.hover) {
        if (elementHover !== undefined) {
          return elementHover;
        }
      } else {
        return "";
      }
    },
  },
  mounted() {},
};
</script>

<style scoped>
.label {
  border: none;
  outline: none;
  width: 100%;
}
.widget,
.d-flex {
  /* position: absolute; */
  width: 100%;
  height: 100%;
}
.d-flex {
  display: flex;
}
input {
  color: inherit;
  text-decoration: inherit;
  text-transform: inherit;
  text-align: inherit;
  font-size: inherit;
}
</style>

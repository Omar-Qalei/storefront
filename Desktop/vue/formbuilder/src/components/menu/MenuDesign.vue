<template>
  <v-container class="menu-design" fluid>
    <!-- <v-switch v-model="position" label="Fixed Menu"></v-switch> -->
    <!-- v-model="panel" -->
    <v-expansion-panels>
      <v-expansion-panel id="colorPicker">
        <v-expansion-panel-header>Background</v-expansion-panel-header>
        <v-expansion-panel-content>
          <Background @styles="stylesBackground($event)" />
        </v-expansion-panel-content>
      </v-expansion-panel>
      <v-expansion-panel>
        <v-expansion-panel-header>Text</v-expansion-panel-header>
        <v-expansion-panel-content>
          <TextDesign @styles="stylesText($event)" />
        </v-expansion-panel-content>
      </v-expansion-panel>
    </v-expansion-panels>
  </v-container>
</template>

<script>
import { mapActions, mapGetters } from "vuex";
import Background from "./design/Background.vue";
import TextDesign from "./design/TextDesign.vue";
export default {
  name: "MenuDesign",
  components: {
    Background,
    TextDesign,
  },
  data() {
    return {
      // panel: 0,
      position: false,
    };
  },
  computed: {
    ...mapGetters(["getSelectedWidgetById"]),
  },
  methods: {
    ...mapActions([""]),
    stylesBackground: function(event) {
      if (this.getSelectedWidgetById.properties.style.menu === undefined) {
        this.$set(this.getSelectedWidgetById.properties.style, "menu", event);
      } else {
        this.getSelectedWidgetById.properties.style.menu = {
          fixedPosition: this.position,
          ...event,
        };
      }
    },
    stylesText: function(event) {
      if (
        this.getSelectedWidgetById.properties.style.elements.text === undefined
      ) {
        this.$set(
          this.getSelectedWidgetById.properties.style.elements,
          "text",
          event
        );
      } else {
        this.getSelectedWidgetById.properties.style.elements.text = event;
      }
    },
  },
  created() {
    this.position = this.getSelectedWidgetById.properties.style.menu.fixedPosition;
    if (this.getSelectedWidgetById.properties.style.elements === null) {
      this.$set(
        this.getSelectedWidgetById.properties.style.elements,
        "text",
        {}
      );
    }
  },
  mounted() {
    // this.width = Math.round(
    //   document.getElementById("colorPicker").getBoundingClientRect().width
    // );
    // console.log(this.width);
  },
  updated() {
    this.getSelectedWidgetById.properties.style.menu.fixedPosition = this.position;
    // this.getSelectedWidgetById.properties.style = {
    //   justifyContent: this.textHorizontal[this.selectedTextHorizontal].title,
    //   alignItems: this.textVertical[this.selectedTextVertical].title,
    //   borderRadius: this.borderRadius + "px",
    //   color: this.textColor,
    //   backgroundColor: this.backgroundColor,
    // };
    // this.getSelectedWidgetById.properties.elementHover = {
    //   color: this.textColorHover,
    //   backgroundColor: this.backgroundColorHover,
    // };
  },
};
</script>

<style scoped></style>

<template>
  <v-container class="carousel-design" fluid>
    <v-expansion-panels>
      <v-expansion-panel>
        <v-expansion-panel-header>Title text</v-expansion-panel-header>
        <v-expansion-panel-content><TitleText /></v-expansion-panel-content>
      </v-expansion-panel>
      <v-expansion-panel>
        <v-expansion-panel-header>Body text</v-expansion-panel-header>
        <v-expansion-panel-content><BodyText /></v-expansion-panel-content>
      </v-expansion-panel>
      <v-expansion-panel>
        <v-expansion-panel-header>Button</v-expansion-panel-header>
        <v-expansion-panel-content
          ><ButtonCarousel
        /></v-expansion-panel-content>
      </v-expansion-panel>
    </v-expansion-panels>
  </v-container>
</template>

<script>
import { mapActions, mapGetters } from "vuex";
import TitleText from "./design/TitleText";
import BodyText from "./design/BodyText";
import ButtonCarousel from "./design/ButtonCarousel";
export default {
  name: "CarouselDesign",
  components: {
    TitleText,
    BodyText,
    ButtonCarousel,
  },
  data() {
    return {
      text: null,
      selectedTextHorizontal: 1,
      selectedTextVertical: 1,
      borderRadius: 4,
      borderRadiusTopLeft: 0,
      borderRadiusTopRight: 0,
      borderRadiusBottomLeft: 0,
      borderRadiusBottomRight: 0,
      selectedUrl: null,
      statusNewTab: false,
      textColor: "#000000de",
      backgroundColor: "#f5f5f5",
      textColorHover: null,
      backgroundColorHover: null,
      elementStatus: "element",
      textHorizontal: [
        { id: 0, title: "flex-start", icon: "mdi-format-align-left" },
        { id: 1, title: "center", icon: "mdi-format-align-center" },
        { id: 2, title: "flex-end", icon: "mdi-format-align-right" },
      ],
      textVertical: [
        { id: 0, title: "flex-start", icon: "mdi-format-align-top" },
        { id: 1, title: "center", icon: "mdi-format-align-middle" },
        { id: 2, title: "flex-end", icon: "mdi-format-align-bottom" },
      ],
      tags: [
        { id: 0, title: "Carousel", value: "element" },
        { id: 1, title: "Hover (Mouse Over)", value: "hover" },
      ],
      pages: ["Home", "About", "Services"],
    };
  },
  computed: {
    ...mapGetters(["getSelectedWidgetById"]),
  },
  methods: {
    ...mapActions([""]),
  },
  updated() {
    this.getSelectedWidgetById.properties.style = {
      justifyContent: this.textHorizontal[this.selectedTextHorizontal].title,
      alignItems: this.textVertical[this.selectedTextVertical].title,
      borderRadius: this.borderRadius + "px",
      color: this.textColor,
      backgroundColor: this.backgroundColor,
    };
    this.getSelectedWidgetById.properties.elementHover = {
      color: this.textColorHover,
      backgroundColor: this.backgroundColorHover,
    };
  },
  destroyed() {
    this.textColorHover = null;
    this.backgroundColorHover = null;
  },
};
</script>

<style scoped>
input[type="range"] {
  width: 100%;
}
</style>

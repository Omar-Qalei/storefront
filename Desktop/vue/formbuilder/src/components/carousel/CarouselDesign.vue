<template>
  <v-container class="carousel-design" fluid>
    <v-expansion-panels>
      <v-expansion-panel>
        <v-expansion-panel-header>Title text</v-expansion-panel-header>
        <v-expansion-panel-content
          ><TitleText @styles="stylesTitleText($event)"
        /></v-expansion-panel-content>
      </v-expansion-panel>
      <v-expansion-panel>
        <v-expansion-panel-header>Body text</v-expansion-panel-header>
        <v-expansion-panel-content
          ><BodyText @styles="stylesBodyText($event)"
        /></v-expansion-panel-content>
      </v-expansion-panel>
      <v-expansion-panel>
        <v-expansion-panel-header>Button</v-expansion-panel-header>
        <v-expansion-panel-content
          ><ButtonCarousel @styles="stylesButtonText($event)" />
        </v-expansion-panel-content>
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
      selectedElementType: null,
      selectedTextHorizontal: 1,
      selectedTextVertical: 1,
      borderRadius: 4,
      borderRadiusTopLeft: 0,
      borderRadiusTopRight: 0,
      borderRadiusBottomLeft: 0,
      borderRadiusBottomRight: 0,
      textColor: "#000000de",
      backgroundColor: "#f5f5f5",
      textColorHover: null,
      backgroundColorHover: null,
      elementStatus: "element",
      styles: {},
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
    };
  },
  computed: {
    ...mapGetters(["getSelectedWidgetById"]),
  },
  methods: {
    ...mapActions([""]),
    stylesTitleText: function(event) {
      this.selectedElementType = "title";
      if (
        this.getSelectedWidgetById.properties.style.elements.title === undefined
      ) {
        this.$set(
          this.getSelectedWidgetById.properties.style.elements,
          "title",
          event
        );
      } else {
        this.getSelectedWidgetById.properties.style.elements.title = event;
      }
    },
    stylesBodyText: function(event) {
      this.selectedElementType = "body";
      if (
        this.getSelectedWidgetById.properties.style.elements.body === undefined
      ) {
        this.$set(
          this.getSelectedWidgetById.properties.style.elements,
          "body",
          event
        );
      } else {
        this.getSelectedWidgetById.properties.style.elements.body = event;
      }
    },
    stylesButtonText: function(event) {
      this.selectedElementType = "button";
      if (
        this.getSelectedWidgetById.properties.style.elements.button ===
        undefined
      ) {
        this.$set(
          this.getSelectedWidgetById.properties.style.elements,
          "button",
          event
        );
      } else {
        this.getSelectedWidgetById.properties.style.elements.button = event;
      }
    },
  },
  watch: {
    styles: function(oldValue, newValue) {
      console.log("styles", oldValue, newValue);
      // if (this.getSelectedWidgetById.properties.style.elements === undefined) {
      //   this.$set(
      //     this.getSelectedWidgetById.properties.style,
      //     "elements",
      //     value
      //   );
      // } else {
      //   switch (this.selectedElementType) {
      //     case "title":
      //       this.getSelectedWidgetById.properties.style.elements.title =
      //         value.title;
      //       break;
      //     case "body":
      //       this.getSelectedWidgetById.properties.style.elements.body =
      //         value.body;
      //       break;
      //     case "button":
      //       console.log(value);
      //       this.getSelectedWidgetById.properties.style.elements.button =
      //         value.button;
      //       break;
      //   }
      // }
    },
  },
  created() {
    if (this.getSelectedWidgetById.properties.style.elements === null) {
      this.$set(
        this.getSelectedWidgetById.properties.style.elements,
        "title",
        {}
      );
      this.$set(
        this.getSelectedWidgetById.properties.style.elements,
        "body",
        {}
      );
      this.$set(
        this.getSelectedWidgetById.properties.style.elements,
        "button",
        {}
      );
    }
  },
  updated() {
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

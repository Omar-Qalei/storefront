<template>
  <v-container class="button-design" fluid>
    <v-row>
      <v-col cols="12">
        <h2 class="body-1 font-weight-medium">
          Text Alignment
        </h2>
      </v-col>
      <v-col cols="6">
        <v-btn-toggle
          return-object
          v-model="selectedTextHorizontal"
          shaped
          mandatory
        >
          <v-btn v-for="text in textHorizontal" :key="text.id" :value="text.id">
            <v-icon>{{ text.icon }}</v-icon>
          </v-btn>
        </v-btn-toggle>
      </v-col>
      <v-col cols="6">
        <v-btn-toggle
          return-object
          v-model="selectedTextVertical"
          shaped
          mandatory
        >
          <v-btn v-for="text in textVertical" :key="text.id" :value="text.id">
            <v-icon>{{ text.icon }}</v-icon>
          </v-btn>
        </v-btn-toggle>
      </v-col>
      <v-col cols="12">
        <v-chip-group
          v-model="elementStatus"
          active-class="primary--text"
          mandatory
        >
          <!--  v-model="selectedLinkTo" -->
          <v-chip v-for="tag in tags" :key="tag.id" :value="tag.value">
            {{ tag.title }}
          </v-chip>
        </v-chip-group>
      </v-col>
      <v-col cols="9">
        <h2 class="body-1 font-weight-medium">
          Text Color
        </h2>
      </v-col>
      <v-col cols="3">
        <ColorPickerWidget
          @colorElement="textColor = $event"
          @colorElementHover="textColorHover = $event"
          :type="elementStatus"
          :color="textColor"
        />
        {{ textColor }} {{ textColorHover }}
      </v-col>
      <v-col cols="9">
        <h2 class="body-1 font-weight-medium">
          Background Color
        </h2>
      </v-col>
      <v-col cols="3">
        <ColorPickerWidget
          @colorElement="backgroundColor = $event"
          @colorElementHover="backgroundColorHover = $event"
          :type="elementStatus"
          :color="backgroundColor"
        />
        {{ backgroundColor }} {{ backgroundColorHover }}
      </v-col>
      <v-col cols="12">
        <h2 class="body-1 font-weight-medium">
          Button Border Radius
        </h2>
      </v-col>
      <v-col cols="9" align-self="center">
        <input v-model="borderRadius" type="range" min="0" max="100" />
      </v-col>
      <v-col cols="2">
        <v-text-field
          outlined
          v-model="borderRadius"
          hide-details
          dense
          label="PX"
        ></v-text-field>
      </v-col>
    </v-row>
  </v-container>
</template>

<script>
import { mapActions, mapGetters } from "vuex";
import ColorPickerWidget from "../../ColorPickerWidget";
import StylesTransform from "../../../mixins/styles";

export default {
  name: "ButtonCarousel",
  mixins: [StylesTransform],
  components: {
    ColorPickerWidget,
  },
  data() {
    return {
      text: null,
      selectedTextHorizontal: 1,
      selectedTextVertical: 1,
      borderRadius: 4,
      selectedUrl: null,
      statusNewTab: false,
      textColor: "#000000de",
      backgroundColor: "#f5f5f5",
      textColorHover: null,
      backgroundColorHover: null,
      elementStatus: "element",
      textHorizontal: [
        { id: 0, title: "start", icon: "mdi-format-align-left" },
        { id: 1, title: "center", icon: "mdi-format-align-center" },
        { id: 2, title: "end", icon: "mdi-format-align-right" },
      ],
      textVertical: [
        { id: 0, title: "flex-start", icon: "mdi-format-align-top" },
        { id: 1, title: "center", icon: "mdi-format-align-middle" },
        { id: 2, title: "flex-end", icon: "mdi-format-align-bottom" },
      ],
      tags: [
        { id: 0, title: "Button", value: "element" },
        { id: 1, title: "Hover (Mouse Over)", value: "hover" },
      ],
    };
  },
  computed: {
    ...mapGetters(["getSelectedWidgetById", "getPages"]),
  },
  methods: {
    ...mapActions([""]),
  },
  created() {
    if (this.getSelectedWidgetById.properties.style) {
      if (this.getSelectedWidgetById.properties.style.elements) {
        if (this.getSelectedWidgetById.properties.style.elements.button) {
          this.selectedTextHorizontal = this.findIndex(
            { list: this.textHorizontal, value: "title" },
            this.getSelectedWidgetById.properties.style.elements.button
              .textAlign
          );
          this.selectedTextVertical = this.findIndex(
            { list: this.textVertical, value: "title" },
            this.getSelectedWidgetById.properties.style.elements.button
              .alignItems
          );
          this.borderRadius = this.convertPxToNumber(
            this.getSelectedWidgetById.properties.style.elements.button
              .borderRadius
          );
          this.textColorHover = this.getSelectedWidgetById.properties.elementHover.color;
          this.backgroundColorHover = this.getSelectedWidgetById.properties.elementHover.backgroundColor;
        }
      }
    }
  },
  updated() {
    const styles = {
      textAlign: this.textHorizontal[this.selectedTextHorizontal].title,
      alignItems: this.textVertical[this.selectedTextVertical].title,
      borderRadius: this.borderRadius + "px",
      color: this.textColor,
      backgroundColor: this.backgroundColor,
    };
    this.getSelectedWidgetById.properties.elementHover = {
      color: this.textColorHover,
      backgroundColor: this.backgroundColorHover,
    };
    this.$emit("styles", styles);
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

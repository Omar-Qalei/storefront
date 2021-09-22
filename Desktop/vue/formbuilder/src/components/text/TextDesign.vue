<template>
  <v-container class="text-design" fluid>
    <v-row class="pt-4">
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
      <v-col cols="12">
        <h2 class="body-1 font-weight-medium">
          Text Type
        </h2>
      </v-col>
      <v-col cols="6">
        <v-btn-toggle
          v-model="selectedTextType"
          shaped
          multiple
          active-class="deep-purple--text text--accent-4"
        >
          <v-btn v-for="text in textTypes" :key="text.id" :value="text.id">
            <v-icon>{{ text.icon }}</v-icon>
          </v-btn>
        </v-btn-toggle>
      </v-col>
      <v-col cols="12">
        <v-chip-group
          v-model="letterCase"
          active-class="primary--text"
          mandatory
        >
          <v-chip v-for="tag in letterCases" :key="tag.id" :value="tag.id">
            {{ tag.title }}
          </v-chip>
        </v-chip-group>
      </v-col>
      <v-col cols="12">
        <v-chip-group
          v-model="elementStatus"
          active-class="primary--text"
          mandatory
        >
          <v-chip v-for="tag in tags" :key="tag.id" :value="tag.value">
            {{ tag.title }}
          </v-chip>
        </v-chip-group>
      </v-col>
      <v-col cols="12">
        <h2 class="body-1 font-weight-medium">
          Text Font Size
        </h2>
      </v-col>
      <v-col cols="12">
        <v-select
          v-model="selectedFontSize"
          :items="fontSizes"
          outlined
          hide-details
          item-text="title"
          item-value="id"
        >
          <template v-slot:item="{ item }">
            <v-row>
              <v-col cols="4">{{ item.title }}</v-col>
              <v-spacer></v-spacer>
              <v-col cols="4">{{ item.value }}</v-col>
            </v-row>
          </template>
        </v-select>
      </v-col>
      <v-col cols="9">
        <h2 class="body-1 font-weight-medium">
          Text Color
        </h2>
      </v-col>
      <v-col cols="3">
        <!-- @colorElementHover="textColorHover = $event" -->
        <ColorPickerWidget
          @colorElement="textColor = $event"
          :type="elementStatus"
          :color="textColor"
        />
        {{ textColor }}
        <!-- {{ textColorHover }} -->
      </v-col>
      <v-col cols="9">
        <h2 class="body-1 font-weight-medium">
          Background Color
        </h2>
      </v-col>
      <!-- @colorElementHover="backgroundColorHover = $event" -->
      <v-col cols="3">
        <ColorPickerWidget
          @colorElement="backgroundColor = $event"
          :type="elementStatus"
          :color="backgroundColor"
        />
        {{ backgroundColor }}
        <!-- {{ backgroundColorHover }} -->
      </v-col>
      <v-col cols="12">
        <h2 class="body-1 font-weight-medium">
          Text Border Radius
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
      <!-- <v-col align-self="center" cols="9">
        <h2 class="body-1 font-weight-medium">
          Text Border Radius Top Left
        </h2>
      </v-col>
      <v-col cols="2">
        <v-text-field
          label="PX"
          outlined
          v-model="borderRadiusTopLeft"
          hide-details
          dense
        ></v-text-field>
      </v-col>
      <v-col align-self="center" cols="9">
        <h2 class="body-1 font-weight-medium">
          Text Border Radius Top Right
        </h2>
      </v-col>
      <v-col cols="2">
        <v-text-field
          outlined
          v-model="borderRadiusTopRight"
          hide-details
          dense
          label="PX"
        ></v-text-field>
      </v-col>
      <v-col align-self="center" cols="9">
        <h2 class="body-1 font-weight-medium">
          Text Border Radius Bottom Left
        </h2>
      </v-col>
      <v-col cols="2">
        <v-text-field
          outlined
          v-model="borderRadiusBottomLeft"
          hide-details
          dense
          label="PX"
        ></v-text-field>
      </v-col>
      <v-col align-self="center" cols="9">
        <h2 class="body-1 font-weight-medium">
          Text Border Radius Bottom Right
        </h2>
      </v-col>
      <v-col cols="2">
        <v-text-field
          outlined
          v-model="borderRadiusBottomRight"
          hide-details
          dense
          label="PX"
        ></v-text-field>
      </v-col> -->
    </v-row>
  </v-container>
</template>

<script>
import { mapActions, mapGetters } from "vuex";
import ColorPickerWidget from "../ColorPickerWidget";
import StylesTransform from "../../mixins/styles";

export default {
  name: "TextDesign",
  mixins: [StylesTransform],
  components: {
    ColorPickerWidget,
  },
  data() {
    return {
      text: null,
      selectedTextHorizontal: 1,
      selectedTextType: [],
      selectedFontSize: 3,
      borderRadius: 4,
      borderRadiusTopLeft: 0,
      borderRadiusTopRight: 0,
      borderRadiusBottomLeft: 0,
      borderRadiusBottomRight: 0,
      textColor: "#000000de",
      backgroundColor: "transparent",
      textColorHover: null,
      backgroundColorHover: null,
      elementStatus: "element",
      letterCase: 0,
      textHorizontal: [
        { id: 0, title: "left", icon: "mdi-format-align-left" },
        { id: 1, title: "center", icon: "mdi-format-align-center" },
        { id: 2, title: "right", icon: "mdi-format-align-right" },
      ],
      textTypes: [
        { id: 0, title: "bold", icon: "mdi-format-bold" },
        { id: 1, title: "italic", icon: "mdi-format-italic" },
        { id: 2, title: "underline", icon: "mdi-format-underline" },
      ],
      fontSizes: [
        { id: 0, title: "paragraph 3", value: "14px" },
        { id: 1, title: "paragraph 2", value: "16px" },
        { id: 2, title: "Paragraph 1", value: "18px" },
        { id: 3, title: "Heading 6", value: "56px" },
        { id: 4, title: "Heading 5", value: "64px" },
        { id: 5, title: "Heading 4", value: "72px" },
        { id: 6, title: "Heading 3", value: "80px" },
        { id: 7, title: "Heading 2", value: "88px" },
        { id: 8, title: "Heading 1", value: "96px" },
      ],
      letterCases: [
        { id: 0, title: "Auto", value: "none", icon: "mdi-text" },
        {
          id: 1,
          title: "Uppercase",
          value: "uppercase",
          icon: "mdi-format-letter-case-upper",
        },
        {
          id: 2,
          title: "Lowercase",
          value: "lowercase",
          icon: "mdi-format-letter-case-lower",
        },
        {
          id: 3,
          title: "Title case",
          value: "capitalize",
          icon: "mdi-format-title",
        },
      ],
      tags: [
        { id: 0, title: "Text", value: "element" },
        // { id: 1, title: "Hover (Mouse Over)", value: "hover" },
      ],
    };
  },
  computed: {
    ...mapGetters(["getSelectedWidgetById"]),
    fontWeight: function() {
      const index = this.selectedTextType.findIndex(
        (element) => element === this.textTypes[0].id
      );
      if (index > -1) {
        return this.textTypes[0].title;
      } else {
        return "";
      }
    },
    fontStyle: function() {
      const index = this.selectedTextType.findIndex(
        (element) => element === this.textTypes[1].id
      );
      if (index > -1) {
        return this.textTypes[1].title;
      } else {
        return "";
      }
    },
    textDecoration: function() {
      const index = this.selectedTextType.findIndex(
        (element) => element === this.textTypes[2].id
      );
      if (index > -1) {
        return this.textTypes[2].title;
      } else {
        return "";
      }
    },
  },
  methods: {
    ...mapActions([""]),
  },
  created() {
    if (this.getSelectedWidgetById.properties.style) {
      this.selectedTextHorizontal = this.findIndex(
        { list: this.textHorizontal, value: "title" },
        this.getSelectedWidgetById.properties.style.textAlign
      );
      this.selectedFontSize = this.findIndex(
        { list: this.fontSizes, value: "value" },
        this.getSelectedWidgetById.properties.style.fontSize
      );
      this.borderRadius = this.convertPxToNumber(
        this.getSelectedWidgetById.properties.style.borderRadius
      );
      this.textColor = this.getSelectedWidgetById.properties.style.color;
      this.backgroundColor = this.getSelectedWidgetById.properties.style.backgroundColor;
      // this.textColorHover = this.getSelectedWidgetById.properties.elementHover.color;
      this.letterCase = this.findIndex(
        { list: this.letterCases, value: "value" },
        this.getSelectedWidgetById.properties.style.textTransform
      );
      this.selectedTextType = [];
      if (this.getSelectedWidgetById.properties.style.fontWeight !== "")
        this.selectedTextType.push(
          this.findIndex(
            { list: this.textTypes, value: "title" },
            this.getSelectedWidgetById.properties.style.fontWeight
          )
        );

      if (this.getSelectedWidgetById.properties.style.fontStyle !== "")
        this.selectedTextType.push(
          this.findIndex(
            { list: this.textTypes, value: "title" },
            this.getSelectedWidgetById.properties.style.fontStyle
          )
        );
      if (this.getSelectedWidgetById.properties.style.textDecoration !== "")
        this.selectedTextType.push(
          this.findIndex(
            { list: this.textTypes, value: "title" },
            this.getSelectedWidgetById.properties.style.textDecoration
          )
        );
    }
  },
  updated() {
    this.getSelectedWidgetById.properties.style = {
      textAlign: this.textHorizontal[this.selectedTextHorizontal].title,
      fontWeight: this.fontWeight,
      fontStyle: this.fontStyle,
      textDecoration: this.textDecoration,
      borderRadius: this.borderRadius + "px",
      color: this.textColor,
      backgroundColor: this.backgroundColor,
      textTransform: this.letterCases[this.letterCase].value,
      fontSize: this.fontSizes[this.selectedFontSize].value,
    };
    // this.getSelectedWidgetById.properties.elementHover = {
    //   color: this.textColorHover,
    // };
  },
  destroyed() {
    // this.textColorHover = null;
    // this.backgroundColorHover = null;
  },
};
</script>

<style scoped>
input[type="range"] {
  width: 100%;
  height: 100%;
}
</style>

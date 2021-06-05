<template>
  <v-container class="text-design" fluid>
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
        <h2 class="body-1 font-weight-medium">
          Text Type
        </h2>
      </v-col>
      <v-col cols="6">
        <v-btn-toggle v-model="selectedTextType" shaped multiple>
          <v-btn v-for="text in textTypes" :key="text.id" :value="text">
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
          <v-chip v-for="tag in letterCases" :key="tag.id" :value="tag.value">
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
      <!-- <v-col cols="12">
        <h2 class="body-1 font-weight-medium">
          Text Font Family
        </h2>
      </v-col>
      <v-col cols="12">
        <v-select
          v-model="selectedFontfamily"
          :items="fontfamilies"
          outlined
          hide-details
          item-text="title"
          item-value="id"
        ></v-select>
      </v-col> -->
      <v-col cols="9">
        <h2 class="body-1 font-weight-medium">
          Text Color
        </h2>
      </v-col>
      <v-col cols="3">
        <ColorPickerWidget
          @colorElement="textColor = $event"
          :type="elementStatus"
          :color="textColor"
        />
        {{ textColor }}
      </v-col>
    </v-row>
  </v-container>
</template>

<script>
import { mapActions, mapGetters } from "vuex";
import ColorPickerWidget from "../../ColorPickerWidget";
export default {
  name: "TitleText",
  components: {
    ColorPickerWidget,
  },
  data() {
    return {
      text: null,
      selectedTextHorizontal: 1,
      selectedTextVertical: 1,
      selectedTextType: [],
      selectedFontSize: 0,
      selectedFontfamily: 0,
      selectedUrl: null,
      statusNewTab: false,
      textColor: "#000000de",
      elementStatus: "element",
      letterCase: 0,
      textHorizontal: [
        { id: 0, title: "left", icon: "mdi-format-align-left" },
        { id: 1, title: "center", icon: "mdi-format-align-center" },
        { id: 2, title: "right", icon: "mdi-format-align-right" },
      ],
      textVertical: [
        { id: 0, title: "flex-start", icon: "mdi-format-align-top" },
        { id: 1, title: "center", icon: "mdi-format-align-middle" },
        { id: 2, title: "flex-end", icon: "mdi-format-align-bottom" },
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
      fontfamilies: [],
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
    };
  },
  computed: {
    ...mapGetters(["getSelectedWidgetById"]),
    fontWeight: function() {
      const index = this.selectedTextType.findIndex(
        (element) => element.title === "bold"
      );
      if (index > -1) {
        return this.selectedTextType.find((element) => element.title === "bold")
          .title;
      } else {
        return "";
      }
    },
    fontStyle: function() {
      const index = this.selectedTextType.findIndex(
        (element) => element.title === "italic"
      );
      if (index > -1) {
        return this.selectedTextType.find(
          (element) => element.title === "italic"
        ).title;
      } else {
        return "";
      }
    },
    textDecoration: function() {
      const index = this.selectedTextType.findIndex(
        (element) => element.title === "underline"
      );
      if (index > -1) {
        return this.selectedTextType.find(
          (element) => element.title === "underline"
        ).title;
      } else {
        return "";
      }
    },
  },
  methods: {
    ...mapActions([""]),
  },
  updated() {
    const styles = {
      textAlign: this.textHorizontal[this.selectedTextHorizontal].title,
      alignSelf: this.textVertical[this.selectedTextVertical].title,
      fontWeight: this.fontWeight,
      fontStyle: this.fontStyle,
      textDecoration: this.textDecoration,
      color: this.textColor,
      textTransform: this.letterCase,
      fontSize: this.fontSizes[this.selectedFontSize].value,
      // fontFamily: this.fontfamilies[this.selectedFontfamily].value,
    };
    this.$emit("styles", styles);
  },
  destroyed() {
    this.textColorHover = null;
  },
};
</script>

<style scoped>
input[type="range"] {
  width: 100%;
}
.v-select {
  z-index: 999;
}
</style>

<template>
  <v-container class="button-design" fluid>
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
      <!-- <v-col align-self="center" cols="9">
        <h2 class="body-1 font-weight-medium">
          Button Border Radius Top Left
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
          Button Border Radius Top Right
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
          Button Border Radius Bottom Left
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
          Button Border Radius Bottom Right
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
export default {
  name: "ButtonDesign",
  components: {
    ColorPickerWidget,
  },
  data() {
    return {
      text: null,
      selectedTextHorizontal: 1,
      selectedTextVertical: 1,
      borderRadius: 25,
      borderRadiusTopLeft: 0,
      borderRadiusTopRight: 0,
      borderRadiusBottomLeft: 0,
      borderRadiusBottomRight: 0,
      selectedUrl: null,
      statusNewTab: false,
      textColor: null,
      backgroundColor: null,
      textColorHover: null,
      backgroundColorHover: null,
      elementStatus: 0,
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
        { id: 0, title: "Button", value: "element" },
        { id: 1, title: "Hover (Mouse Over)", value: "hover" },
      ],
      pages: ["Home", "About", "Services"],
    };
  },
  computed: {
    ...mapGetters(["getSelectedWidgetById", "getRefElement"]),
  },
  methods: {
    ...mapActions([""]),
  },
  created() {
    let style = document.getElementById(this.getSelectedWidgetById.i + "button")
      .style;
    console.log(style);
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
};
</script>

<style scoped>
input[type="range"] {
  width: 100%;
}
</style>

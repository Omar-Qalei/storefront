<template>
  <v-container class="form-design" fluid>
    <v-expansion-panels v-model="panels" key="form">
      <!-- Form -->
      <v-expansion-panel>
        <v-expansion-panel-header>Form</v-expansion-panel-header>
        <v-expansion-panel-content>
          <v-row>
            <v-col cols="12">
              <h2 class="body-1 font-weight-medium">
                Text Alignment
              </h2>
            </v-col>
            <v-col cols="6">
              <v-btn-toggle v-model="form.textAlign" shaped mandatory>
                <v-btn
                  v-for="text in textAlignments"
                  :key="text.id"
                  :value="text.id"
                >
                  <v-icon>{{ text.icon }}</v-icon>
                </v-btn>
              </v-btn-toggle>
            </v-col>
            <v-col cols="9">
              <h2 class="body-1 font-weight-medium">
                Border Width
              </h2>
            </v-col>
            <v-col cols="2">
              <v-text-field
                outlined
                v-model="form.borderWidth"
                hide-details
                dense
                label="PX"
              ></v-text-field>
            </v-col>
            <v-col cols="9">
              <h2 class="body-1 font-weight-medium">
                Border Color
              </h2>
            </v-col>
            <v-col cols="3">
              <ColorPickerWidget
                @colorElement="form.borderColor = $event"
                :type="elementStatus"
                :color="form.borderColor"
              />
              {{ form.borderColor }}
            </v-col>
            <v-col cols="9">
              <h2 class="body-1 font-weight-medium">
                Background Color
              </h2>
            </v-col>
            <v-col cols="3">
              <ColorPickerWidget
                @colorElement="form.backgroundColor = $event"
                :type="elementStatus"
                :color="form.backgroundColor"
              />
              {{ form.backgroundColor }}
            </v-col>
            <v-col cols="12">
              <h2 class="body-1 font-weight-medium">
                Form Border Radius
              </h2>
            </v-col>
            <v-col cols="9" align-self="center">
              <input
                v-model="form.borderRadius"
                type="range"
                min="0"
                max="100"
              />
            </v-col>
            <v-col cols="2">
              <v-text-field
                outlined
                v-model="form.borderRadius"
                hide-details
                dense
                label="PX"
              ></v-text-field>
            </v-col>
          </v-row>
        </v-expansion-panel-content>
      </v-expansion-panel>
      <!-- Form -->

      <!-- Field -->
      <v-expansion-panel>
        <v-expansion-panel-header>Field</v-expansion-panel-header>
        <v-expansion-panel-content>
          <v-row>
            <v-col cols="9">
              <h2 class="body-1 font-weight-medium">
                Font Size
              </h2>
            </v-col>
            <v-col cols="2">
              <v-text-field
                outlined
                v-model="field.fontSize"
                hide-details
                dense
                label="PX"
              ></v-text-field>
            </v-col>
            <v-col cols="9">
              <h2 class="body-1 font-weight-medium">
                Text Color
              </h2>
            </v-col>
            <v-col cols="3">
              <ColorPickerWidget
                @colorElement="field.color = $event"
                :type="elementStatus"
                :color="field.color"
              />
              {{ field.color }}
            </v-col>
            <v-col cols="9">
              <h2 class="body-1 font-weight-medium">
                Background Color
              </h2>
            </v-col>
            <v-col cols="3">
              <ColorPickerWidget
                @colorElement="field.backgroundColor = $event"
                :type="elementStatus"
                :color="field.backgroundColor"
              />
              {{ field.backgroundColor }} {{ field.backgroundColorHover }}
            </v-col>
            <v-col cols="12">
              <h2 class="body-1 font-weight-medium">
                Field Border Radius
              </h2>
            </v-col>
            <v-col cols="9" align-self="center">
              <input
                v-model="field.borderRadius"
                type="range"
                min="0"
                max="100"
              />
            </v-col>
            <v-col cols="2">
              <v-text-field
                outlined
                v-model="field.borderRadius"
                hide-details
                dense
                label="PX"
              ></v-text-field>
            </v-col>
          </v-row>
        </v-expansion-panel-content>
      </v-expansion-panel>
      <!-- Field -->

      <!-- Button -->
      <v-expansion-panel>
        <v-expansion-panel-header>Button</v-expansion-panel-header>
        <v-expansion-panel-content>
          <v-row class="pt-4">
            <v-col cols="12">
              <h2 class="body-1 font-weight-medium">
                Text Alignment
              </h2>
            </v-col>
            <v-col cols="6">
              <v-btn-toggle
                return-object
                v-model="button.selectedTextHorizontal"
                shaped
                mandatory
              >
                <v-btn
                  v-for="text in textHorizontal"
                  :key="text.id"
                  :value="text.id"
                >
                  <v-icon>{{ text.icon }}</v-icon>
                </v-btn>
              </v-btn-toggle>
            </v-col>
            <v-col cols="6">
              <v-btn-toggle
                return-object
                v-model="button.selectedTextVertical"
                shaped
                mandatory
              >
                <v-btn
                  v-for="text in textVertical"
                  :key="text.id"
                  :value="text.id"
                >
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
                @colorElement="button.textColor = $event"
                @colorElementHover="button.textColorHover = $event"
                :type="elementStatus"
                :color="button.textColor"
              />
              {{ button.textColor }} {{ button.textColorHover }}
            </v-col>
            <v-col cols="9">
              <h2 class="body-1 font-weight-medium">
                Background Color
              </h2>
            </v-col>
            <v-col cols="3">
              <ColorPickerWidget
                @colorElement="button.backgroundColor = $event"
                @colorElementHover="button.backgroundColorHover = $event"
                :type="elementStatus"
                :color="button.backgroundColor"
              />
              {{ button.backgroundColor }} {{ button.backgroundColorHover }}
            </v-col>
            <v-col cols="12">
              <h2 class="body-1 font-weight-medium">
                Button Border Radius
              </h2>
            </v-col>
            <v-col cols="9" align-self="center">
              <input
                v-model="button.borderRadius"
                type="range"
                min="0"
                max="100"
              />
            </v-col>
            <v-col cols="2">
              <v-text-field
                outlined
                v-model="button.borderRadius"
                hide-details
                dense
                label="PX"
              ></v-text-field>
            </v-col>
          </v-row>
        </v-expansion-panel-content>
      </v-expansion-panel>
      <!-- Button -->
    </v-expansion-panels>
  </v-container>
</template>

<script>
import { mapActions, mapGetters } from "vuex";
import ColorPickerWidget from "../ColorPickerWidget";
import StylesTransform from "../../mixins/styles";

export default {
  name: "FormDesign",
  mixins: [StylesTransform],
  components: {
    ColorPickerWidget,
  },
  data() {
    return {
      panels: 0,
      borderRadiusTopLeft: 0,
      borderRadiusTopRight: 0,
      borderRadiusBottomLeft: 0,
      borderRadiusBottomRight: 0,
      form: {
        textAlign: 1,
        border: "solid",
        backgroundColor: "#EBEBEBFF",
        borderRadius: 21,
        borderWidth: 10,
        borderColor: "transparent",
      },
      field: {
        fontSize: 16,
        color: "#000000de",
        backgroundColor: "#FFFFFFFF",
        borderRadius: 40,
      },
      button: {
        textColor: "#FFFFFFFF",
        backgroundColor: "#4E00BBFF",
        textColorHover: "#FFFFFFFF",
        backgroundColorHover: "#A05CFFFF",
        borderRadius: 16,
        selectedTextHorizontal: 1,
        selectedTextVertical: 1,
      },
      elementStatus: "element",
      textAlignments: [
        { id: 0, title: "left", icon: "mdi-format-align-left" },
        { id: 1, title: "center", icon: "mdi-format-align-center" },
        { id: 2, title: "right", icon: "mdi-format-align-right" },
      ],
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
    };
  },
  computed: {
    ...mapGetters(["getSelectedWidgetById"]),
  },
  methods: {
    ...mapActions([""]),
  },
  created() {
    if (this.getSelectedWidgetById.properties.style === null) {
      this.getSelectedWidgetById.properties.style = {
        form: this.form,
        field: this.field,
        button: this.button,
      };
      this.$set(this.getSelectedWidgetById.properties.style, "form", null);
    } else {
      if (this.getSelectedWidgetById.properties.style.form) {
        this.form.textAlign = this.findIndex(
          { list: this.textAlignments, value: "title" },
          this.getSelectedWidgetById.properties.style.form.textAlign
        );
        this.form.borderRadius = this.convertPxToNumber(
          this.getSelectedWidgetById.properties.style.form.borderRadius
        );
        this.form.borderWidth = this.convertPxToNumber(
          this.getSelectedWidgetById.properties.style.form.borderWidth
        );
        this.form.borderColor = this.getSelectedWidgetById.properties.style.form.borderColor;
        this.form.backgroundColor = this.getSelectedWidgetById.properties.style.form.backgroundColor;
      }
      // Fields
      if (this.getSelectedWidgetById.properties.style.field) {
        this.field.fontSize = this.convertPxToNumber(
          this.getSelectedWidgetById.properties.style.field.fontSize
        );
        this.field.borderRadius = this.convertPxToNumber(
          this.getSelectedWidgetById.properties.style.field.borderRadius
        );
        this.field.color = this.getSelectedWidgetById.properties.style.field.color;
        this.field.backgroundColor = this.getSelectedWidgetById.properties.style.field.backgroundColor;
      }
      // Button
      if (this.getSelectedWidgetById.properties.style.button) {
        this.button.selectedTextHorizontal = this.findIndex(
          { list: this.textHorizontal, value: "title" },
          this.getSelectedWidgetById.properties.style.button.justifyContent
        );
        this.button.selectedTextVertical = this.findIndex(
          { list: this.textVertical, value: "title" },
          this.getSelectedWidgetById.properties.style.button.alignItems
        );
        this.button.borderRadius = this.convertPxToNumber(
          this.getSelectedWidgetById.properties.style.button.borderRadius
        );
        this.button.textColor = this.getSelectedWidgetById.properties.style.button.color;
        this.button.backgroundColor = this.getSelectedWidgetById.properties.style.button.backgroundColor;
        this.button.textColorHover = this.getSelectedWidgetById.properties.elementHover.color;
        this.button.backgroundColorHover = this.getSelectedWidgetById.properties.elementHover.backgroundColor;
      }
    }
  },
  updated() {
    this.getSelectedWidgetById.properties.style = {
      form: {
        textAlign: this.textHorizontal[this.form.textAlign].title,
        border: this.form.border,
        backgroundColor: this.form.backgroundColor,
        borderRadius: this.form.borderRadius + "px",
        borderWidth: this.form.borderWidth + "px",
        borderColor: this.form.borderColor,
      },
      field: {
        fontSize: this.field.fontSize + "px",
        color: this.field.color,
        backgroundColor: this.field.backgroundColor,
        borderRadius: this.field.borderRadius + "px",
      },
      button: {
        justifyContent: this.textHorizontal[this.button.selectedTextHorizontal]
          .title,
        alignItems: this.textVertical[this.button.selectedTextVertical].title,
        borderRadius: this.button.borderRadius + "px",
        color: this.button.textColor,
        backgroundColor: this.button.backgroundColor,
      },
    };
    // this.getSelectedWidgetById.properties.style.form = {
    //   backgroundColor: this.form.backgroundColor,
    //   borderRadius: this.form.borderRadius + "px",
    //   borderWidth: this.form.borderWidth + "px",
    //   borderColor: this.form.borderColor,
    // };
    // this.getSelectedWidgetById.properties.style.field = {
    //   fontSize: this.field.fontSize + "px",
    //   color: this.field.color,
    //   backgroundColor: this.field.backgroundColor,
    //   borderRadius: this.field.borderRadius + "px",
    // };
    // this.getSelectedWidgetById.properties.style.button = {
    //   justifyContent: this.textHorizontal[this.button.selectedTextHorizontal]
    //     .title,
    //   alignItems: this.textVertical[this.button.selectedTextVertical].title,
    //   borderRadius: this.button.borderRadius + "px",
    //   color: this.button.textColor,
    //   backgroundColor: this.button.backgroundColor,
    // };
    this.getSelectedWidgetById.properties.elementHover = {
      color: this.button.textColorHover,
      backgroundColor: this.button.backgroundColorHover,
    };
  },
  destroyed() {
    this.button.textColorHover = null;
    this.button.backgroundColorHover = null;
  },
};
</script>

<style scoped>
input[type="range"] {
  width: 100%;
}
</style>

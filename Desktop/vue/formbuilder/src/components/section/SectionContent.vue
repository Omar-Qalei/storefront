<template>
  <v-container class="section-design" fluid>
    <v-expansion-panels v-model="panels">
      <v-expansion-panel>
        <v-expansion-panel-header>
          Backrgound Color
        </v-expansion-panel-header>
        <v-expansion-panel-content>
          <v-row class="pt-4">
            <v-col
              cols="12"
              class="backgroundSection"
              :style="{
                background: section.background,
              }"
            >
            </v-col>
            <v-col cols="9">
              <h2 class="body-1 font-weight-medium">
                Background Color
              </h2>
            </v-col>
            <v-col cols="3">
              <ColorPickerWidget
                @colorElement="section.background = $event"
                :type="elementStatus"
                :color="section.background"
              />
            </v-col>
          </v-row>
        </v-expansion-panel-content>
      </v-expansion-panel>
      <v-expansion-panel>
        <v-expansion-panel-header>
          Backrgound Gradient
        </v-expansion-panel-header>
        <v-expansion-panel-content>
          <v-row class="pt-4">
            <v-col
              cols="12"
              class="backgroundSection"
              :style="{
                background: section.background,
              }"
            >
            </v-col>
            <v-col cols="12">
              <v-select
                :items="backgroundGradientTypes"
                v-model="selectedBackgroundGradientType"
                item-text="title"
                item-value="id"
                label="Gradient Type"
                hide-details
                value="id"
                outlined
              >
                <template v-slot:item="{ item }">
                  {{ item.title }}
                </template>
              </v-select>
            </v-col>
            <v-col cols="12">
              <h2 class="body-1 font-weight-medium">
                Gradient Direction
              </h2>
            </v-col>
            <v-col cols="9" align-self="center">
              <input
                v-model="gradientDirection"
                type="range"
                min="0"
                max="360"
              />
            </v-col>
            <v-col cols="3">
              <v-text-field
                outlined
                v-model="gradientDirection"
                hide-details
                dense
                label="PX"
              ></v-text-field>
            </v-col>
            <v-col cols="12">
              <h2 class="body-1 font-weight-medium">
                Start Position
              </h2>
            </v-col>
            <v-col cols="9" align-self="center">
              <input
                v-model="gradientStartPosition"
                type="range"
                min="0"
                max="100"
              />
            </v-col>
            <v-col cols="3">
              <v-text-field
                outlined
                v-model="gradientStartPosition"
                hide-details
                dense
                label="%"
              ></v-text-field>
            </v-col>
            <v-col cols="12">
              <h2 class="body-1 font-weight-medium">
                End Position
              </h2>
            </v-col>
            <v-col cols="9" align-self="center">
              <input
                v-model="gradientEndPosition"
                type="range"
                min="0"
                max="100"
              />
            </v-col>
            <v-col cols="3">
              <v-text-field
                outlined
                v-model="gradientEndPosition"
                hide-details
                dense
                label="%"
              ></v-text-field>
            </v-col>
            <v-col cols="9">
              <h2 class="body-1 font-weight-medium">
                Background Color
              </h2>
            </v-col>
            <v-col cols="3">
              <ColorPickerWidget
                @colorElement="
                  gradientFirstColor = $event;
                  gradientColor();
                "
                :type="elementStatus"
                :color="section.background"
              />
            </v-col>
            <v-col cols="9">
              <h2 class="body-1 font-weight-medium">
                Background Color
              </h2>
            </v-col>
            <v-col cols="3">
              <ColorPickerWidget
                @colorElement="
                  gradientSecondColor = $event;
                  gradientColor();
                "
                :type="elementStatus"
                :color="section.background"
              />
            </v-col>
          </v-row>
        </v-expansion-panel-content>
      </v-expansion-panel>
      <v-expansion-panel>
        <v-expansion-panel-header>
          Backrgound Image
        </v-expansion-panel-header>
        <v-expansion-panel-content>
          <v-row class="pt-4">
            <v-col
              cols="12"
              class="backgroundSection"
              :style="{
                background: section.background,
                backgroundSize: section.backgroundSize,
                backgroundPosition: section.backgroundPosition,
                backgroundRepeat: section.backgroundRepeat,
                backgroundBlendMode: section.backgroundBlendMode,
              }"
            >
              <label class="labelFile" v-if="!section.background">
                <input
                  type="file"
                  class="d-none"
                  @change="backgroundImage($event)"
                />
                <h2 class="body-1 font-weight-medium">
                  Add Background Image
                </h2>
              </label>
            </v-col>
            <!-- <v-col cols="12">
              <v-switch
                label="Use Parallax Effect"
                v-model="isParallax"
              ></v-switch>
            </v-col> -->
            <v-col cols="12">
              <h2 class="body-1 font-weight-medium mb-2">
                Background Image Size
              </h2>
              <v-select
                :items="backgroundImageSize"
                v-model="selectedBackgroundImageSize"
                item-text="title"
                item-value="id"
                hide-details
                outlined
              ></v-select>
            </v-col>
            <v-col cols="12">
              <h2 class="body-1 font-weight-medium mb-2">
                Background Image Position
              </h2>
              <v-select
                :items="backgroundImagePosition"
                v-model="selectedBackgroundImagePosition"
                item-text="title"
                item-value="id"
                hide-details
                outlined
              ></v-select>
            </v-col>
            <v-col cols="12">
              <h2 class="body-1 font-weight-medium mb-2">
                Background Image Repeat
              </h2>
              <v-select
                :items="backgroundImageRepeat"
                v-model="selectedBackgroundImageRepeat"
                item-text="title"
                item-value="id"
                hide-details
                outlined
              ></v-select>
            </v-col>
            <v-col cols="12">
              <h2 class="body-1 font-weight-medium mb-2">
                Background Image Blend
              </h2>
              <v-select
                :items="backgroundImageBlend"
                v-model="selectedBackgroundImageBlend"
                item-text="title"
                item-value="id"
                hide-details
                outlined
              ></v-select>
            </v-col>
          </v-row>
        </v-expansion-panel-content>
      </v-expansion-panel>
      <v-expansion-panel>
        <v-expansion-panel-header>
          Backrgound Video
        </v-expansion-panel-header>
        <v-expansion-panel-content>
          <v-row class="pt-4">
            <v-col
              cols="12"
              class="backgroundSection"
              :style="{
                background: section.background,
              }"
            >
              <video
                v-if="backgroundVideo"
                :src="backgroundVideo"
                autoplay
                loop
                playsinline
                muted
              ></video>
              <label class="labelFile" v-else>
                <input
                  type="file"
                  class="d-none"
                  @change="uploadBackgroundVideo($event)"
                />
                <h2 class="body-1 font-weight-medium">
                  Add Background Video
                </h2>
              </label>
            </v-col>
          </v-row>
        </v-expansion-panel-content>
      </v-expansion-panel>
    </v-expansion-panels>
  </v-container>
</template>

<script>
import { mapGetters } from "vuex";
import ColorPickerWidget from "../ColorPickerWidget";
export default {
  name: "SectionContent",
  components: {
    ColorPickerWidget,
  },
  data() {
    return {
      panels: 0,
      elementStatus: "element",
      gradientDirection: 45,
      gradientFirstColor: "#FFF",
      gradientSecondColor: "#FFF",
      selectedBackgroundGradientType: 0,
      gradientStartPosition: 20,
      gradientEndPosition: 20,
      isParallax: false,
      selectedBackgroundImageSize: 0,
      selectedBackgroundImagePosition: 0,
      selectedBackgroundImageRepeat: 0,
      selectedBackgroundImageBlend: 0,
      backgroundGradientTypes: [
        { id: 0, title: "Linear Gradient", type: "linearGradient" },
        { id: 1, title: "Radial Gradient", type: "radialGradient" },
      ],
      backgroundImageSize: [
        { id: 0, title: "Cover", type: "cover" },
        { id: 1, title: "Fit", type: "contain" },
        { id: 2, title: "Actual Size", type: "auto" },
      ],
      backgroundImagePosition: [
        { id: 0, title: "Top Left", type: "top left" },
        { id: 1, title: "Top Center", type: "top center" },
        { id: 2, title: "Top Right", type: "top right" },
        { id: 3, title: "Center Left", type: "center left" },
        { id: 4, title: "Center", type: "center" },
        { id: 5, title: "Center Right", type: "center right" },
        { id: 6, title: "Bottom Left", type: "bottom left" },
        { id: 7, title: "Bottom Center", type: "bottom center" },
        { id: 8, title: "Bottom Right", type: "bottom right" },
      ],
      backgroundImageRepeat: [
        { id: 0, title: "No Repeat", type: "no-repeat" },
        { id: 1, title: "Repeat", type: "repeat" },
        { id: 2, title: "Repeat X (horizontal)", type: "repeat-x" },
        { id: 3, title: "Repeat Y (vertical)", type: "repeat-y" },
        { id: 4, title: "Space", type: "space" },
        { id: 5, title: "Round", type: "round" },
      ],
      backgroundImageBlend: [
        { id: 0, title: "Normal", type: "normal" },
        { id: 1, title: "Multiply", type: "multiply" },
        { id: 2, title: "Screen", type: "screen" },
        { id: 3, title: "Overlay", type: "overlay" },
        { id: 4, title: "Darken", type: "darken" },
        { id: 5, title: "Lighten", type: "lighten" },
        { id: 6, title: "Color Dodge", type: "color-dodge" },
        { id: 7, title: "Color Burn", type: "color-burn" },
        { id: 8, title: "Hard Light", type: "hard-light" },
        { id: 9, title: "Soft Light", type: "soft-light" },
        { id: 10, title: "Difference", type: "difference" },
        { id: 11, title: "Exclusion", type: "exclusion" },
        { id: 12, title: "Hue", type: "hue" },
        { id: 13, title: "Saturation", type: "saturation" },
        { id: 14, title: "Color", type: "color" },
        { id: 15, title: "Luminosity", type: "luminosity" },
      ],
      backgroundVideo: null,
      section: {
        textAlign: "left",
        border: "solid",
        background: "transparent",
        borderRadius: 0,
        borderWidth: 0,
        borderColor: "transparent",
        backgroundSize: "",
        backgroundPosition: "",
        backgroundRepeat: "",
        backgroundBlendMode: "",
      },
    };
  },
  computed: {
    ...mapGetters(["getSelectedWidgetById"]),
  },
  methods: {
    gradientColor: function() {
      switch (this.selectedBackgroundGradientType) {
        case 0:
          this.section.background =
            "linear-gradient(" +
            this.gradientDirection +
            "deg," +
            this.gradientFirstColor +
            " " +
            this.gradientStartPosition +
            "%," +
            this.gradientSecondColor +
            " " +
            this.gradientEndPosition +
            "%)";
          console.log(this.section.background);
          break;
        case 1:
          this.section.background =
            "radial-gradient(" +
            this.gradientFirstColor +
            "," +
            this.gradientSecondColor +
            ")";
          break;
      }
    },
    backgroundImage: function(event) {
      console.log(event);
      this.section.background =
        "url(https://cdn.vuetifyjs.com/images/cards/server-room.jpg)";
    },
    uploadBackgroundVideo: function(event) {
      console.log(event);
      this.backgroundVideo =
        "https://css-tricks-post-videos.s3.us-east-1.amazonaws.com/Island%20-%204141.mp4";
    },
  },
  watch: {
    panels: function(oldValue, newValue) {
      if (
        oldValue !== undefined &&
        oldValue !== newValue &&
        newValue !== undefined
      ) {
        this.section.background = "";
      }
    },
    gradientDirection: function() {
      this.gradientColor();
    },
    gradientStartPosition: function() {
      this.gradientColor();
    },
    gradientEndPosition: function() {
      this.gradientColor();
    },
  },
  updated() {
    this.getSelectedWidgetById.properties.selectedLinkTo = this.selectedLinkTo;
    this.section.backgroundSize = this.backgroundImageSize[
      this.selectedBackgroundImageSize
    ].type;
    this.section.backgroundPosition = this.backgroundImagePosition[
      this.selectedBackgroundImagePosition
    ].type;
    this.section.backgroundRepeat = this.backgroundImageRepeat[
      this.selectedBackgroundImageRepeat
    ].type;
    this.section.backgroundBlendMode = this.backgroundImageBlend[
      this.selectedBackgroundImageBlend
    ].type;
  },
};
</script>

<style>
.backgroundSection {
  height: 150px;
  border-radius: 4px;
  border: 1px solid black;
}
.v-select {
  z-index: 999;
}
input[type="range"] {
  width: 100%;
}
.labelFile {
  display: flex;
  height: 100%;
  width: 100%;
  align-items: center;
  justify-content: center;
}
video {
  width: 100%;
  height: 100%;
}
</style>

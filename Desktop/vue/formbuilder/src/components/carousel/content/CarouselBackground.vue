<template>
  <div>
    <v-row>
      <v-col cols="12">
        <v-chip-group
          active-class="primary--text"
          mandatory
          v-model="selectedLinkTo"
        >
          <v-chip v-for="tag in tags" :key="tag.id">
            {{ tag.title }}
          </v-chip>
        </v-chip-group>
      </v-col>
    </v-row>

    <!-- Background color -->
    <v-row v-if="selectedLinkTo === 0">
      <v-col cols="12">
        <v-flex id="colorPicker">
          <!-- <v-color-picker
                  dot-size="10"
                  mode="hexa"
                  flat
                  :swatches="swatches"
                  show-swatches
                  swatches-max-height="200"
                  :width.sync="width"
                ></v-color-picker> -->
          <ColorPickerExpandWidget
            v-if="width"
            :width="width"
            @colorElement="carousel.background = $event"
            :type="elementStatus"
            :color="carousel.background"
          />
        </v-flex>
      </v-col>
      <!-- <v-col cols="9">
              <h2 class="body-1 font-weight-medium">
                Background Color
              </h2>
            </v-col>
            <v-col cols="3">
              <ColorPickerWidget
                @colorElement="carousel.background = $event"
                :type="elementStatus"
                :color="carousel.background"
              />
            </v-col> -->
    </v-row>
    <!-- Background color -->

    <!-- Background gradient color -->
    <v-row v-if="selectedLinkTo === 1">
      <v-col cols="6">
        <v-btn class="text-capitalize" text @click="onShowPicker('firstColor')">
          <v-avatar
            class="mr-2 elevation-2"
            size="25"
            :color="gradientFirstColor"
          />
          Select Color
        </v-btn>
      </v-col>
      <v-col cols="6">
        <!-- <ColorPickerWidget
                @colorElement="
                  gradientFirstColor = $event;
                  gradientColor();
                "
                :type="elementStatus"
                :color="carousel.background"
              /> -->
        <v-btn
          class="text-capitalize"
          text
          @click="onShowPicker('secondColor')"
        >
          <v-avatar
            class="mr-2 elevation-2"
            size="25"
            :color="gradientSecondColor"
          />
          Select Color
        </v-btn>
      </v-col>
      <v-col cols="12">
        <v-expand-transition>
          <v-card v-show="showPickerColor">
            <v-flex id="colorPicker">
              <ColorPickerExpandWidget
                v-if="width && currentGradientColor"
                :width="width"
                @colorElement="
                  selectedColor = $event;
                  onChangeSelectedColor();
                  gradientColor();
                "
                :type="elementStatus"
                :color="currentGradientColor"
              />
            </v-flex>
          </v-card>
        </v-expand-transition>
      </v-col>
      <v-col cols="6">
        <!-- <ColorPickerWidget
                @colorElement="
                  gradientFirstColor = $event;
                  gradientColor();
                "
                :type="elementStatus"
                :color="carousel.background"
              /> -->
        <!-- <v-btn class="text-capitalize" text>
                <v-avatar class="mr-2" size="15" :color="'blue'" />
                Select Color
              </v-btn> -->
      </v-col>
      <v-col cols="6">
        <!-- <v-btn class="text-capitalize" text>
                <v-avatar class="mr-2" size="15" :color="'blue'" />
                Select Color
              </v-btn> -->
        <!-- <ColorPickerWidget
                @colorElement="
                  gradientSecondColor = $event;
                  gradientColor();
                "
                :type="elementStatus"
                :color="carousel.background"
              /> -->
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
          @change="gradientColor()"
        >
          <template v-slot:item="{ item }">
            {{ item.title }}
          </template>
        </v-select>
      </v-col>
      <template v-if="selectedBackgroundGradientType === 0">
        <v-col cols="12">
          <h2 class="body-1 font-weight-medium">
            Gradient Direction
          </h2>
        </v-col>
        <v-col cols="9" align-self="center">
          <input v-model="gradientDirection" type="range" min="0" max="360" />
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
          <input v-model="gradientEndPosition" type="range" min="0" max="100" />
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
      </template>
    </v-row>
    <!-- Background gradient color -->

    <!-- Background Image -->
    <v-row v-if="selectedLinkTo === 2">
      <v-col
        cols="12"
        class="backgroundElement"
        :style="{
          background: carousel.background,
          backgroundSize: carousel.backgroundSize,
          backgroundPosition: carousel.backgroundPosition,
          backgroundRepeat: carousel.backgroundRepeat,
          backgroundBlendMode: carousel.backgroundBlendMode,
        }"
        @click="onShowChooseFilesDialog(true)"
      >
        <label class="labelFile">
          <h2 class="body-1 font-weight-medium" v-if="!carousel.background">
            Add Background Image
          </h2>
        </label>
      </v-col>
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
    <!-- Background Image -->

    <!-- Background Video -->
    <v-row v-if="selectedLinkTo === 3">
      <v-col cols="12">
        <h2 class="body-1 font-weight-medium mb-2">
          Video URL
        </h2>
        <v-text-field
          outlined
          placeholder="https://www.video-example.com"
          v-model="backgroundVideo"
          hide-details
        ></v-text-field>
      </v-col>
      <!-- <v-col
        cols="12"
        class="backgroundElement"
        :style="{
          background: carousel.background,
        }"
        @click="onShowChooseFilesDialog(true)"
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
          <h2 class="body-1 font-weight-medium">
            Add Background Video
          </h2>
        </label>
      </v-col> -->
    </v-row>
    <!-- Background Video -->

    <!-- Choose Files -->
    <ChooseFilesWidget
      @onSelectedImage="onSelectedImage($event)"
      @onSelectedVideo="onSelectedVideo($event)"
    />
  </div>
</template>

<script>
import { mapGetters, mapActions } from "vuex";
import ColorPickerExpandWidget from "../../ColorPickerExpandWidget";
import ChooseFilesWidget from "../../options/ChooseFilesWidget";
import StylesTransform from "../../../mixins/styles";

export default {
  name: "CarouselBackground",
  mixins: [StylesTransform],
  components: {
    ColorPickerExpandWidget,
    ChooseFilesWidget,
  },
  data() {
    return {
      panels: 0,
      elementStatus: "element",
      gradientDirection: 45,
      gradientFirstColor: "#009695FF",
      gradientSecondColor: "#009695FF",
      selectedBackgroundGradientType: 0,
      gradientStartPosition: 20,
      gradientEndPosition: 20,
      isParallax: false,
      selectedColor: null,
      selectedTypeColor: null,
      selectedBackgroundImageSize: 0,
      selectedBackgroundImagePosition: 0,
      selectedBackgroundImageRepeat: 0,
      selectedBackgroundImageBlend: 0,
      dblSelectedFirstColor: 0,
      dblSelectedSecondColor: 0,
      width: null,
      showPickerColor: false,
      currentGradientColor: null,
      tags: [
        { id: 0, title: "Color", type: "" },
        { id: 1, title: "Gradient", type: "" },
        { id: 2, title: "Image", type: "backgroundImage" },
        { id: 3, title: "Video", type: "backgroundVideo" },
      ],
      backgroundGradientTypes: [
        { id: 0, title: "Linear Gradient", type: "linearGradient" },
        { id: 1, title: "Radial Gradient", type: "radialGradient" },
      ],
      backgroundImageSize: [
        { id: 0, title: "Actual Size", type: "auto" },
        { id: 1, title: "Cover", type: "cover" },
        { id: 2, title: "Fit", type: "contain" },
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
        { id: 0, title: "Repeat", type: "repeat" },
        { id: 1, title: "No Repeat", type: "no-repeat" },
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
      backgroundImage: null,
      carousel: {
        // textAlign: "left",
        // border: "solid",
        background: "#009695FF",
        borderRadius: 0,
        // borderWidth: 0,
        // borderColor: "transparent",
        backgroundSize: "",
        backgroundPosition: "",
        backgroundRepeat: "",
        backgroundBlendMode: "",
      },
      selectedLinkTo: 0,
    };
  },
  computed: {
    ...mapGetters(["getSelectedWidgetById", "getShowChooseFilesDialog"]),
  },
  methods: {
    ...mapActions(["onShowChooseFilesDialog", "onTypeChooseFileDialog"]),
    gradientColor: function() {
      this.$set(
        this.getSelectedWidgetById.properties,
        "selectedBackgroundGradientType",
        this.selectedBackgroundGradientType
      );
      switch (this.selectedBackgroundGradientType) {
        case 0:
          this.carousel.background =
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
          break;
        case 1:
          this.carousel.background =
            "radial-gradient(" +
            this.gradientFirstColor +
            "," +
            this.gradientSecondColor +
            ")";
          break;
      }
    },
    uploadBackgroundVideo: function(event) {
      console.log(event);
    },
    onShowPicker: function(result) {
      this.selectedTypeColor = result;
      switch (result) {
        case "firstColor":
          this.dblSelectedSecondColor = 0;
          this.dblSelectedFirstColor += 1;
          this.currentGradientColor = this.gradientFirstColor;
          if (this.dblSelectedFirstColor % 2 === 0) {
            this.dblSelectedFirstColor = 0;
            this.showPickerColor = false;
          } else {
            this.showPickerColor = true;
          }
          break;
        case "secondColor":
          this.dblSelectedFirstColor = 0;
          this.dblSelectedSecondColor += 1;
          this.currentGradientColor = this.gradientSecondColor;
          if (this.dblSelectedSecondColor % 2 === 0) {
            this.dblSelectedSecondColor = 0;
            this.showPickerColor = false;
          } else {
            this.showPickerColor = true;
          }
          break;
      }
    },
    onChangeSelectedColor: function() {
      switch (this.selectedTypeColor) {
        case "firstColor":
          this.gradientFirstColor = this.selectedColor;
          break;
        case "secondColor":
          this.gradientSecondColor = this.selectedColor;
          break;
      }
    },
    onSelectedImage: function(event) {
      this.carousel.background = event;
    },
    onSelectedVideo: function(event) {
      this.backgroundVideo = event;
    },
    onCheckTypeBackground: function(background) {
      this.carousel.background = background;
      let str = background;
      if (str.charAt(0) === "#") {
        this.carousel.background = background;
      } else {
        str = str.split("(");
        switch (str[0]) {
          case "linear-gradient":
            this.onDecodeBackgroundGradient(background);
            break;
          case "radial-gradient":
            this.onDecodeBackgroundGradient(background);
            break;
          case "url":
            this.backgroundImage = background;
            break;
        }
      }
    },
    onDecodeBackgroundGradient: function(background) {
      let str = background;
      let firstColor,
        secondColor,
        gradientDirection,
        firstColorPercent,
        secondColorPercent;
      str = str.split("(").toString();
      str = str.split(")").toString();
      str = str.split(",");
      switch (str[0]) {
        case "linear-gradient":
          gradientDirection = +str[1].toString().split("deg")[0];
          firstColor = str[2].toString().split(" ")[0];
          firstColorPercent = str[2]
            .toString()
            .split(" ")[1]
            .toString()
            .split("%")[0];
          secondColor = str[3].toString().split(" ")[0];
          secondColorPercent = str[3]
            .toString()
            .split(" ")[1]
            .toString()
            .split("%")[0];
          this.gradientDirection = gradientDirection;
          this.gradientFirstColor = firstColor;
          this.gradientStartPosition = firstColorPercent;
          this.gradientSecondColor = secondColor;
          this.gradientEndPosition = secondColorPercent;
          break;
        case "radial-gradient":
          firstColor = str[1].toString().split(" ")[0];
          secondColor = str[2].toString().split(" ")[0];
          this.gradientFirstColor = firstColor;
          this.gradientSecondColor = secondColor;
          break;
      }
    },
  },
  watch: {
    selectedLinkTo: function(newValue, oldValue) {
      this.onTypeChooseFileDialog(this.tags[newValue].type);
      if (
        newValue !== undefined &&
        newValue !== oldValue &&
        oldValue !== undefined
      ) {
        this.carousel.background = "";
      }
      if (this.tags[newValue].type !== "backgroundVideo")
        this.getSelectedWidgetById.properties.backgroundVideo = null;
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
    backgroundImage: function(val) {
      this.carousel.background = val;
    },
  },
  created() {
    if (this.getSelectedWidgetById.properties.style.carousel) {
      if (this.getSelectedWidgetById.properties.selectedLinkTo)
        this.selectedLinkTo = this.getSelectedWidgetById.properties.selectedLinkTo;
      if (this.getSelectedWidgetById.properties.selectedBackgroundGradientType)
        this.selectedBackgroundGradientType = this.getSelectedWidgetById.properties.selectedBackgroundGradientType;
      if (this.getSelectedWidgetById.properties.style.carousel.background)
        this.onCheckTypeBackground(
          this.getSelectedWidgetById.properties.style.carousel.background
        );
      if (this.getSelectedWidgetById.properties.style.carousel.backgroundSize)
        this.selectedBackgroundImageSize = this.findIndex(
          { list: this.backgroundImageSize, value: "type" },
          this.getSelectedWidgetById.properties.style.carousel.backgroundSize
        );
      if (
        this.getSelectedWidgetById.properties.style.carousel.backgroundPosition
      )
        this.selectedBackgroundImagePosition = this.findIndex(
          { list: this.backgroundImagePosition, value: "type" },
          this.getSelectedWidgetById.properties.style.carousel
            .backgroundPosition
        );
      if (this.getSelectedWidgetById.properties.style.carousel.backgroundRepeat)
        this.selectedBackgroundImageRepeat = this.findIndex(
          { list: this.backgroundImageRepeat, value: "type" },
          this.getSelectedWidgetById.properties.style.carousel.backgroundRepeat
        );
      if (
        this.getSelectedWidgetById.properties.style.carousel.backgroundBlendMode
      )
        this.selectedBackgroundImageBlend = this.findIndex(
          { list: this.backgroundImageBlend, value: "type" },
          this.getSelectedWidgetById.properties.style.carousel
            .backgroundBlendMode
        );
      if (this.getSelectedWidgetById.properties.backgroundVideo)
        this.backgroundVideo = this.getSelectedWidgetById.properties.backgroundVideo;
    }
  },
  mounted() {
    this.width = Math.round(
      document.getElementById("colorPicker").getBoundingClientRect().width
    );
  },
  updated() {
    if (this.getSelectedWidgetById.properties.style !== null) {
      this.getSelectedWidgetById.properties.selectedLinkTo = this.selectedLinkTo;
      this.carousel.backgroundSize = this.backgroundImageSize[
        this.selectedBackgroundImageSize
      ].type;
      this.carousel.backgroundPosition = this.backgroundImagePosition[
        this.selectedBackgroundImagePosition
      ].type;
      this.carousel.backgroundRepeat = this.backgroundImageRepeat[
        this.selectedBackgroundImageRepeat
      ].type;
      this.carousel.backgroundBlendMode = this.backgroundImageBlend[
        this.selectedBackgroundImageBlend
      ].type;
      this.getSelectedWidgetById.properties.style.carousel = this.carousel;
      this.getSelectedWidgetById.properties.backgroundVideo = this.backgroundVideo;
    }
  },
};
</script>

<style scoped>
.backgroundElement {
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
::v-deep.v-color-picker canvas {
  /* width: 300px !important; */
}
</style>

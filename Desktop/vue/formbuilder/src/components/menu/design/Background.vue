<template>
  <v-container class="menu-design" fluid>
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
          <ColorPickerExpandWidget
            v-if="width"
            :width="width"
            @colorElement="menu.background = $event"
            :type="elementStatus"
            :color="menu.background"
          />
        </v-flex>
      </v-col>
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
                v-if="width"
                :width="width"
                @colorElement="
                  selectedColor = $event;
                  onChangeSelectedColor();
                  gradientColor();
                "
                :type="elementStatus"
                :color="menu.background"
              />
            </v-flex>
          </v-card>
        </v-expand-transition>
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
  </v-container>
</template>

<script>
import { mapActions, mapGetters } from "vuex";
import ColorPickerExpandWidget from "../../ColorPickerExpandWidget";
import StylesTransform from "../../../mixins/styles";

export default {
  name: "Background",
  mixins: [StylesTransform],
  components: {
    ColorPickerExpandWidget,
  },
  data() {
    return {
      // We will be remove it
      afterCreated: false,
      panels: 0,
      elementStatus: "element",
      gradientDirection: 45,
      gradientFirstColor: "#FFF",
      gradientSecondColor: "#FFF",
      selectedBackgroundGradientType: 0,
      gradientStartPosition: 20,
      gradientEndPosition: 20,
      isParallax: false,
      selectedColor: null,
      selectedTypeColor: null,
      dblSelectedFirstColor: 0,
      dblSelectedSecondColor: 0,
      width: null,
      showPickerColor: false,
      tags: [
        { id: 0, title: "Color" },
        { id: 1, title: "Gradient" },
      ],
      backgroundGradientTypes: [
        { id: 0, title: "Linear Gradient", type: "linearGradient" },
        { id: 1, title: "Radial Gradient", type: "radialGradient" },
      ],
      menu: {
        textAlign: "left",
        // border: "solid",
        background: null,
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
    ...mapGetters(["getSelectedWidgetById"]),
  },
  methods: {
    ...mapActions(["onShowChooseFilesDialog", "onTypeChooseFileDialog"]),
    gradientColor: function() {
      switch (this.selectedBackgroundGradientType) {
        case 0:
          this.menu.background =
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
          this.menu.background =
            "radial-gradient(" +
            this.gradientFirstColor +
            "," +
            this.gradientSecondColor +
            ")";
          break;
      }
    },
    onShowPicker: function(result) {
      this.selectedTypeColor = result;
      switch (result) {
        case "firstColor":
          this.dblSelectedSecondColor = 0;
          this.dblSelectedFirstColor += 1;

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
    onCheckTypeBackground: function(background) {
      this.menu.background = background;
      let str = background;
      if (str.charAt(0) === "#") {
        this.menu.background = background;
      } else {
        str = str.split("(");
        switch (str[0]) {
          case "linear-gradient":
            this.onDecodeBackgroundGradient(background);
            break;
          case "radial-gradient":
            this.onDecodeBackgroundGradient(background);
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
          firstColorPercent = str[2].toString().split(" ")[1];
          secondColor = str[3].toString().split(" ")[0];
          secondColorPercent = str[3].toString().split(" ")[1];
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
        this.afterCreated &&
        newValue !== undefined &&
        newValue !== oldValue &&
        oldValue !== undefined
      ) {
        this.menu.background = "";
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
  created() {
    this.afterCreated = false;
    if (this.getSelectedWidgetById.properties.style) {
      if (this.getSelectedWidgetById.properties.style.menu) {
        if (this.getSelectedWidgetById.properties.style.menu.background)
          this.onCheckTypeBackground(
            this.getSelectedWidgetById.properties.style.menu.background
          );
        if (
          this.getSelectedWidgetById.properties.style.menu
            .selectedBackgroundGradientType
        )
          this.selectedBackgroundGradientType = this.findIndex(
            { list: this.backgroundGradientTypes, value: "type" },
            this.getSelectedWidgetById.properties.style.menu
              .selectedBackgroundGradientType
          );
      }
    }
  },
  mounted() {
    this.width = Math.round(
      document.getElementById("colorPicker").getBoundingClientRect().width
    );
    if (this.getSelectedWidgetById.properties.selectedLinkTo)
      this.selectedLinkTo = this.getSelectedWidgetById.properties.selectedLinkTo;
  },
  beforeUpdate() {
    this.afterCreated = true;
  },
  updated() {
    this.getSelectedWidgetById.properties.selectedLinkTo = this.selectedLinkTo;
    // this.menu.selectedBackgroundGradientType = this.backgroundGradientTypes[
    //   this.selectedBackgroundGradientType
    // ].type;
    // this.getSelectedWidgetById.properties.style = this.menu;
    const styles = {
      selectedBackgroundGradientType: this.backgroundGradientTypes[
        this.selectedBackgroundGradientType
      ].type,
      ...this.menu,
    };
    this.$emit("styles", styles);
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
</style>

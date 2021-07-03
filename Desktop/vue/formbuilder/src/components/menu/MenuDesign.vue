<template>
  <v-container class="menu-design" fluid>
    <!-- <v-row class="pt-4">
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
          Menu Border Radius
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
    </v-row> -->
    <v-switch v-model="position" label="Fixed Menu"></v-switch>
    <v-expansion-panels>
      <v-expansion-panel>
        <v-expansion-panel-header>Background</v-expansion-panel-header>
        <v-expansion-panel-content>
          <!-- Background color -->
          <v-row v-if="selectedLinkTo === 0">
            <v-col cols="12">
              <v-flex id="colorPicker">
                <ColorPickerExpandWidget
                  v-if="width"
                  :width="width"
                  @colorElement="section.background = $event"
                  :type="elementStatus"
                  :color="section.background"
                />
              </v-flex>
            </v-col>
          </v-row>
          <!-- Background color -->

          <!-- Background gradient color -->
          <v-row v-if="selectedLinkTo === 1">
            <v-col cols="6">
              <v-btn
                class="text-capitalize"
                text
                @click="onShowPicker('firstColor')"
              >
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
                      :color="section.background"
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
            </template>
          </v-row>
          <!-- Background gradient color -->
        </v-expansion-panel-content>
      </v-expansion-panel>
      <v-expansion-panel>
        <v-expansion-panel-header>Text</v-expansion-panel-header>
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
                v-model="selectedTextHorizontal"
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
          </v-row>
        </v-expansion-panel-content>
      </v-expansion-panel>
    </v-expansion-panels>
  </v-container>
</template>

<script>
import { mapActions, mapGetters } from "vuex";
import ColorPickerWidget from "../ColorPickerWidget";
export default {
  name: "MenuDesign",
  components: {
    ColorPickerWidget,
  },
  data() {
    return {
      text: null,
      position: false,
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
      selectedLinkTo: 0,
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
        { id: 0, title: "Menu", value: "element" },
        { id: 1, title: "Active link", value: "hover" },
      ],
    };
  },
  computed: {
    ...mapGetters(["getSelectedWidgetById"]),
  },
  methods: {
    ...mapActions([""]),
  },
  mounted() {
    this.width = Math.round(
      document.getElementById("colorPicker").getBoundingClientRect().width
    );
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

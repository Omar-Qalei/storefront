<template>
  <v-container class="carousel-content px-0" fluid>
    <v-stepper class="elevation-0" v-model="slide">
      <v-stepper-items>
        <!-- Add Slide -->
        <v-stepper-content class="px-0" step="1">
          <v-row>
            <v-col cols="12">
              <v-card class="mx-2">
                <draggable v-model="list" class="w-100">
                  <v-card-actions
                    class="py-2"
                    v-for="(item, index) in list"
                    :key="index"
                  >
                    <h2 class="body-2 font-weight-medium">
                      <v-btn x-small icon color="primary">
                        <v-icon color="primary">mdi mdi-drag</v-icon>
                      </v-btn>
                      {{ item.title }}
                    </h2>
                    <v-spacer></v-spacer>
                    <v-btn
                      x-small
                      icon
                      color="primary"
                      @click="onSelectedSlide(index)"
                    >
                      <v-icon color="primary">mdi mdi-cog-outline</v-icon>
                    </v-btn>
                    <v-btn
                      x-small
                      icon
                      color="primary"
                      @click="onDuplicate(item)"
                    >
                      <v-icon color="primary">mdi mdi-content-duplicate</v-icon>
                    </v-btn>
                    <v-btn
                      x-small
                      icon
                      color="primary"
                      @click="onRemove(item)"
                      :disabled="list.length <= 2"
                    >
                      <v-icon color="primary">mdi mdi-delete-outline</v-icon>
                    </v-btn>
                  </v-card-actions>
                </draggable>
              </v-card>
            </v-col>
            <v-col cols="12" class="text-center">
              <v-btn
                class="text-capitalize"
                text
                color="primary"
                @click="onAddSlide"
                >Add New Slide</v-btn
              >
            </v-col>
          </v-row>
          <v-row class="px-4">
            <v-col cols="12">
              <v-checkbox
                v-model="allowLoop"
                label="Allow Loop"
                hide-details
              ></v-checkbox>
              <v-checkbox
                v-model="allowArrow"
                label="Allow Arrows"
                hide-details
              ></v-checkbox>
              <v-checkbox
                v-model="allowDots"
                label="Disable Dots"
                hide-details
              ></v-checkbox>
            </v-col>
          </v-row>
        </v-stepper-content>
        <!-- Add Slide -->

        <!-- Slide Setting -->
        <v-stepper-content class="pa-0" step="2">
          <v-btn text color="primary" @click="goBack">
            <v-icon>mdi-arrow-left</v-icon>
          </v-btn>
          <v-expansion-panels class="pa-2 pt-4" v-model="panels">
            <v-expansion-panel>
              <v-expansion-panel-header>
                Text
              </v-expansion-panel-header>
              <v-expansion-panel-content>
                <CarouselText
                  v-if="selectedSlideIndex !== null"
                  :index="selectedSlideIndex"
                />
              </v-expansion-panel-content>
            </v-expansion-panel>
            <v-expansion-panel>
              <v-expansion-panel-header id="colorPicker">
                Backrgound
              </v-expansion-panel-header>
              <v-expansion-panel-content>
                <CarouselBackground />
              </v-expansion-panel-content>
            </v-expansion-panel>
            <v-expansion-panel>
              <v-expansion-panel-header id="colorPicker">
                Button
              </v-expansion-panel-header>
              <v-expansion-panel-content>
                <CarouselButton />
              </v-expansion-panel-content>
            </v-expansion-panel>
          </v-expansion-panels>
        </v-stepper-content>
        <!-- Slide Setting -->
      </v-stepper-items>
    </v-stepper>
  </v-container>
</template>

<script>
import { mapGetters } from "vuex";
import draggable from "vuedraggable";
import CarouselBackground from "./content/CarouselBackground";
import CarouselText from "./content/CarouselText";
import CarouselButton from "./content/CarouselButton";

export default {
  name: "CarouselContent",
  components: {
    draggable,
    CarouselBackground,
    CarouselText,
    CarouselButton,
  },
  data() {
    return {
      slide: 1,
      panels: 0,
      selectedSlideIndex: null,
      allowLoop: true,
      allowArrow: true,
      allowDots: false,
      list: [
        {
          icon: "mdi-play-box-outline",
          title: "Slide one Title",
          textButton: "Learn more",
          body: "Write your text here and add as many slides as you want...",
          type: "carousel",
        },
        {
          icon: "mdi-play-box-outline",
          title: "Slide Two Title",
          textButton: "Learn more",
          body: "Write your text here and add as many slides as you want...",
          type: "carousel",
        },
      ],
    };
  },
  computed: {
    ...mapGetters(["getSelectedWidgetById"]),
  },
  methods: {
    onAddSlide: function() {
      this.list.push({
        icon: "mdi-play-box-outline",
        title: "Slide",
        textButton: "Learn more",
        body: "Write your text here and add as many slides as you want...",
        type: "carousel",
      });
    },
    onDuplicate: function(item) {
      this.list.push(item);
    },
    onRemove: function(item) {
      const index = this.list.findIndex((element) => element.i === item.i);
      this.list.splice(index, 1);
    },
    onSelectedSlide: function(index) {
      this.slide = 2;
      this.selectedSlideIndex = index;
    },
    goBack: function() {
      this.slide = 1;
      this.selectedSlideIndex = null;
    },
  },
  created() {
    if (this.getSelectedWidgetById.properties.fields.length)
      this.list = this.getSelectedWidgetById.properties.fields;

    if (this.getSelectedWidgetById.properties.allowLoop)
      this.allowLoop = this.getSelectedWidgetById.properties.allowLoop;

    if (this.getSelectedWidgetById.properties.allowArrow)
      this.allowArrow = this.getSelectedWidgetById.properties.allowArrow;

    if (this.getSelectedWidgetById.properties.allowDots)
      this.allowDots = this.getSelectedWidgetById.properties.allowDots;

    if (this.getSelectedWidgetById.properties.allowLoop === undefined)
      this.$set(this.getSelectedWidgetById.properties, "allowLoop", false);
    if (this.getSelectedWidgetById.properties.allowArrow === undefined)
      this.$set(this.getSelectedWidgetById.properties, "allowArrow", true);
    if (this.getSelectedWidgetById.properties.allowDots === undefined)
      this.$set(this.getSelectedWidgetById.properties, "allowDots", false);
  },
  updated() {
    this.getSelectedWidgetById.properties.fields = this.list;
    this.getSelectedWidgetById.properties.allowLoop = this.allowLoop;
    this.getSelectedWidgetById.properties.allowArrow = this.allowArrow;
    this.getSelectedWidgetById.properties.allowDots = this.allowDots;
  },
};
</script>

<style scoped></style>

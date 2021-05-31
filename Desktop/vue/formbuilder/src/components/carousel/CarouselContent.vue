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
                      {{ item.text }}
                    </h2>
                    <v-spacer></v-spacer>
                    <v-btn x-small icon color="primary" @click="slide = 2">
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
                    <v-btn x-small icon color="primary" @click="onRemove(item)">
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
        </v-stepper-content>
        <!-- Add Slide -->

        <!-- Slide Setting -->
        <v-stepper-content class="pa-0" step="2">
          <!-- <v-btn color="primary" @click="slide = 1">
            Back
          </v-btn> -->
          <v-expansion-panels class="pa-2 pt-4" v-model="panels">
            <v-expansion-panel>
              <v-expansion-panel-header>
                Text
              </v-expansion-panel-header>
              <v-expansion-panel-content>
                <CarouselText />
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

export default {
  name: "CarouselContent",
  components: {
    draggable,
    CarouselBackground,
    CarouselText,
  },
  data() {
    return {
      slide: 1,
      panels: 0,
      text: null,
      selectedLinkTo: 0,
      selectedPage: null,
      selectedUrl: null,
      statusNewTab: false,
      list: [
        {
          icon: "mdi-play-box-outline",
          text: "Slide",
          label: "",
          placerholder: "",
          type: "carousel",
        },
        {
          icon: "mdi-play-box-outline",
          text: "Slide",
          label: "",
          placerholder: "",
          type: "carousel",
        },
      ],
      tags: [
        { id: 0, title: "Page" },
        { id: 1, title: "URL" },
        { id: 2, title: "Phone" },
        { id: 3, title: "Email" },
      ],
      pages: ["Home", "About", "Services"],
    };
  },
  computed: {
    ...mapGetters(["getSelectedWidgetById"]),
  },
  methods: {
    onAddSlide: function() {
      this.list.push({
        icon: "mdi-play-box-outline",
        text: "Slide",
        label: "",
        placerholder: "",
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
  },
  updated() {
    this.getSelectedWidgetById.properties.selectedLinkTo = this.selectedLinkTo;
  },
};
</script>

<style scoped></style>

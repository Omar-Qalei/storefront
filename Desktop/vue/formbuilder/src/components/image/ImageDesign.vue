<template>
  <v-container class="image-design" fluid>
    <v-row class="pt-4">
      <v-col cols="12">
        <h2 class="body-1 font-weight-medium">
          Image Position
        </h2>
      </v-col>
      <v-col cols="6">
        <v-select
          :items="ImagePositions"
          v-model="selectedObjectFit"
          item-text="title"
          item-value="value"
          outlined
        ></v-select>
      </v-col>

      <v-col cols="12">
        <h2 class="body-1 font-weight-medium">
          Image Border Radius
        </h2>
      </v-col>
      <v-col cols="12">
        <v-chip-group
          v-model="selectedImagePosition"
          active-class="primary--text"
          mandatory
        >
          <v-chip v-for="tag in tags" :key="tag.id" :value="tag.id">
            {{ tag.title }}
          </v-chip>
        </v-chip-group>
      </v-col>
      <template v-if="selectedImagePosition === 0">
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
      </template>
      <template v-else>
        <v-col align-self="center" cols="9">
          <h2 class="body-1 font-weight-medium">
            Border Radius Top Left
          </h2>
        </v-col>
        <v-col cols="2">
          <v-text-field
            label="PX"
            outlined
            v-model="borderTopLeftRadius"
            hide-details
            dense
          ></v-text-field>
        </v-col>
        <v-col align-self="center" cols="9">
          <h2 class="body-1 font-weight-medium">
            Border Radius Top Right
          </h2>
        </v-col>
        <v-col cols="2">
          <v-text-field
            outlined
            v-model="borderTopRightRadius"
            hide-details
            dense
            label="PX"
          ></v-text-field>
        </v-col>
        <v-col align-self="center" cols="9">
          <h2 class="body-1 font-weight-medium">
            Border Radius Bottom Left
          </h2>
        </v-col>
        <v-col cols="2">
          <v-text-field
            outlined
            v-model="borderBottomLeftRadius"
            hide-details
            dense
            label="PX"
          ></v-text-field>
        </v-col>
        <v-col align-self="center" cols="9">
          <h2 class="body-1 font-weight-medium">
            Border Radius Bottom Right
          </h2>
        </v-col>
        <v-col cols="2">
          <v-text-field
            outlined
            v-model="borderBottomRightRadius"
            hide-details
            dense
            label="PX"
          ></v-text-field>
        </v-col>
      </template>
    </v-row>
  </v-container>
</template>

<script>
import { mapActions, mapGetters } from "vuex";
export default {
  name: "ImageDesign",
  components: {},
  data() {
    return {
      selectedObjectFit: "fill",
      borderRadius: 4,
      borderTopLeftRadius: 4,
      borderTopRightRadius: 4,
      borderBottomLeftRadius: 4,
      borderBottomRightRadius: 4,
      selectedImagePosition: 0,
      ImagePositions: [
        { id: 0, title: "Fill", value: "fill" },
        { id: 1, title: "Cover", value: "cover" },
        { id: 2, title: "Contain", value: "contain" },
        { id: 3, title: "Actual Size", value: "none" },
      ],
      tags: [
        { id: 0, title: "All", value: "all" },
        { id: 1, title: "Only", value: "only" },
      ],
    };
  },
  computed: {
    ...mapGetters(["getSelectedWidgetById"]),
  },
  methods: {
    ...mapActions([""]),
  },
  watch: {
    selectedImagePosition: function(value) {
      switch (value) {
        case 0:
          this.borderRadius = 4;
          break;
        case 1:
          this.borderTopLeftRadius = 4;
          this.borderTopRightRadius = 4;
          this.borderBottomLeftRadius = 4;
          this.borderBottomRightRadius = 4;
          break;
      }
    },
  },
  updated() {
    this.getSelectedWidgetById.properties.style = {
      objectFit: this.selectedObjectFit,
      borderRadius: this.borderRadius + "px",
      borderTopLeftRadius: this.borderTopLeftRadius + "px",
      borderTopRightRadius: this.borderTopRightRadius + "px",
      borderBottomLeftRadius: this.borderBottomLeftRadius + "px",
      borderBottomRightRadius: this.borderBottomRightRadius + "px",
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

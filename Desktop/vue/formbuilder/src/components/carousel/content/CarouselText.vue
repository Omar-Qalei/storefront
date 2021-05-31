<template>
  <v-row class="pt-4">
    <v-col cols="8">
      <h2 class="body-1 font-weight-medium mb-2">
        Title
      </h2>
      <v-text-field
        outlined
        v-model="getSelectedWidgetById.properties.name"
        hide-details
      ></v-text-field>
    </v-col>
    <v-col cols="8">
      <h2 class="body-1 font-weight-medium mb-2">
        Button
      </h2>
      <v-text-field
        outlined
        v-model="getSelectedWidgetById.properties.textButton"
        hide-details
      ></v-text-field>
    </v-col>
    <v-col cols="12">
      <h2 class="body-1 font-weight-medium mb-2">
        Body
      </h2>
      <v-textarea
        outlined
        v-model="getSelectedWidgetById.properties.body"
        name="input-7-4"
        value="The Woodman set to work at once, and so sharp was his axe that the tree was soon chopped nearly through."
      ></v-textarea>
    </v-col>
  </v-row>
</template>

<script>
import { mapGetters } from "vuex";
export default {
  name: "CarouselText",
  data() {
    return {
      text: null,
    };
  },
  computed: {
    ...mapGetters(["getSelectedWidgetById"]),
  },
  updated() {},
};
</script>
<style scoped></style>

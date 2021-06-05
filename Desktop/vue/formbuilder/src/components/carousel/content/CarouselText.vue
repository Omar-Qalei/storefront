<template>
  <v-row class="pt-4">
    <v-col cols="8">
      <h2 class="body-1 font-weight-medium mb-2">
        Title
      </h2>
      <v-text-field outlined v-model="title" hide-details></v-text-field>
    </v-col>
    <v-col cols="8">
      <h2 class="body-1 font-weight-medium mb-2">
        Button
      </h2>
      <v-text-field outlined v-model="textButton" hide-details></v-text-field>
    </v-col>
    <v-col cols="12">
      <h2 class="body-1 font-weight-medium mb-2">
        Body
      </h2>
      <v-textarea
        outlined
        v-model="body"
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
      title: null,
      textButton: null,
      body: null,
    };
  },
  props: {
    index: Number,
  },
  computed: {
    ...mapGetters(["getSelectedWidgetById"]),
  },
  mounted() {
    if (this.getSelectedWidgetById.properties.fields[this.index]) {
      this.title = this.getSelectedWidgetById.properties.fields[
        this.index
      ].title;
      this.textButton = this.getSelectedWidgetById.properties.fields[
        this.index
      ].textButton;
      this.body = this.getSelectedWidgetById.properties.fields[this.index].body;
    }
  },
  updated() {
    this.getSelectedWidgetById.properties.fields[this.index].title = this.title;
    this.getSelectedWidgetById.properties.fields[
      this.index
    ].textButton = this.textButton;
    this.getSelectedWidgetById.properties.fields[this.index].body = this.body;
  },
};
</script>
<style scoped></style>

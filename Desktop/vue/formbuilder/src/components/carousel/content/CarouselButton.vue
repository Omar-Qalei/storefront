<template>
  <v-container class="button-content" fluid>
    <v-row class="pt-4">
      <v-col cols="12">
        <h2 class="body-1 font-weight-medium mb-2">
          Link to
        </h2>
        <v-chip-group
          active-class="primary--text"
          mandatory
          v-model="selectedButtonLinkTo"
        >
          <v-chip v-for="tag in tags" :key="tag.id">
            {{ tag.title }}
          </v-chip>
        </v-chip-group>
      </v-col>
      <v-col cols="12">
        <h2 class="body-1 font-weight-medium mb-2">
          {{ tags[selectedButtonLinkTo].title }}
        </h2>
        <v-select
          v-if="selectedButtonLinkTo === 0"
          :items="getPages"
          v-model="getSelectedWidgetById.properties.page"
          item-text="name"
          return-object
          outlined
        ></v-select>
        <template v-if="selectedButtonLinkTo === 1">
          <v-text-field
            placeholder="https://www.example.com"
            v-model="getSelectedWidgetById.properties.url"
            outlined
            hide-details
          ></v-text-field>
          <v-switch
            label="Open a new tab"
            v-model="getSelectedWidgetById.properties.newTab"
          ></v-switch>
        </template>
        <v-text-field
          v-if="selectedButtonLinkTo === 2"
          placeholder="Ex. 079-501-218"
          v-model="getSelectedWidgetById.properties.phone"
          outlined
          hide-details
        ></v-text-field>
        <v-text-field
          v-if="selectedButtonLinkTo === 3"
          placeholder="example@example.com"
          v-model="getSelectedWidgetById.properties.email"
          outlined
          hide-details
        ></v-text-field>
      </v-col>
    </v-row>
  </v-container>
</template>

<script>
import { mapGetters } from "vuex";
export default {
  name: "CarouselButton",
  data() {
    return {
      selectedButtonLinkTo: 0,
      selectedPage: null,
      selectedUrl: null,
      statusNewTab: false,
      tags: [
        { id: 0, title: "Page" },
        { id: 1, title: "URL" },
        { id: 2, title: "Phone" },
        { id: 3, title: "Email" },
      ],
    };
  },
  computed: {
    ...mapGetters(["getSelectedWidgetById", "getPages"]),
  },
  created() {
    if (this.getSelectedWidgetById.properties.selectedButtonLinkTo)
      this.selectedButtonLinkTo = this.getSelectedWidgetById.properties.selectedButtonLinkTo;
  },
  updated() {
    this.getSelectedWidgetById.properties.selectedButtonLinkTo = this.selectedButtonLinkTo;
  },
};
</script>

<style scoped>
.v-select {
  z-index: 999;
}
</style>

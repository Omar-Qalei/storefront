<template>
  <v-container class="text-content" fluid>
    <v-row class="pt-4">
      <v-col cols="8">
        <h2 class="body-1 font-weight-medium mb-2">
          Text
        </h2>
        <v-text-field
          outlined
          v-model="getSelectedWidgetById.properties.name"
          hide-details
        ></v-text-field>
      </v-col>
      <v-col cols="12">
        <h2 class="body-1 font-weight-medium mb-2">
          Link to
        </h2>
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
      <v-col cols="12">
        <h2 class="body-1 font-weight-medium mb-2">
          {{ tags[selectedLinkTo].title }}
        </h2>
        <v-select
          v-if="selectedLinkTo === 0"
          :items="pages"
          v-model="getSelectedWidgetById.properties.page"
          outlined
        ></v-select>
        <template v-if="selectedLinkTo === 1">
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
          v-if="selectedLinkTo === 2"
          placeholder="Ex. 079-501-218"
          v-model="getSelectedWidgetById.properties.phone"
          outlined
          hide-details
        ></v-text-field>
        <v-text-field
          v-if="selectedLinkTo === 3"
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
  name: "TextContent",
  data() {
    return {
      text: null,
      selectedLinkTo: 0,
      selectedPage: null,
      selectedUrl: null,
      statusNewTab: false,
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
  updated() {
    this.getSelectedWidgetById.properties.selectedLinkTo = this.selectedLinkTo;
  },
};
</script>

<style></style>

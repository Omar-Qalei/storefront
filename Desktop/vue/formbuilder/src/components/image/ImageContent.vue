<template>
  <v-container class="image-content" fluid>
    <v-row class="pt-4">
      <v-col cols="12">
        <h2 class="body-1 font-weight-medium mb-2">
          Upload Image
        </h2>
        <v-col cols="12" class="backgroundSection">
          <img v-if="image" :src="image" />
          <label class="labelFile" v-else>
            <input type="file" class="d-none" @change="uploadImage($event)" />
            <h2 class="body-1 font-weight-medium">
              Add Image
            </h2>
          </label>
        </v-col>
      </v-col>
      <v-col cols="8">
        <h2 class="body-1 font-weight-medium mb-2">
          Alt Text (SEO)
        </h2>
        <v-text-field
          outlined
          v-model="getSelectedWidgetById.properties.alt"
          hint="Use alt text to describe the image and help search engines understand your page content better."
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
  name: "ImageContent",
  data() {
    return {
      text: null,
      selectedLinkTo: 0,
      selectedPage: null,
      selectedUrl: null,
      statusNewTab: false,
      image: null,
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
    uploadImage: function(event) {
      console.log(event);
      this.image = "https://cdn.vuetifyjs.com/images/cards/server-room.jpg";
    },
  },
  updated() {
    this.getSelectedWidgetById.properties.selectedLinkTo = this.selectedLinkTo;
    this.getSelectedWidgetById.properties.image = this.image;
  },
};
</script>

<style scoped>
img {
  width: 100%;
  height: 100%;
}
.backgroundSection {
  height: 150px;
  border-radius: 4px;
  border: 1px solid black;
}
.labelFile {
  display: flex;
  height: 100%;
  width: 100%;
  align-items: center;
  justify-content: center;
}
</style>

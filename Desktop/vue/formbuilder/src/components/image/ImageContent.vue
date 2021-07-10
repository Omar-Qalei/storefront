<template>
  <v-container class="image-content" fluid>
    <v-row class="pt-4">
      <v-col cols="12">
        <h2 class="body-1 font-weight-medium mb-2">
          Upload Image
        </h2>
        <v-col
          cols="12"
          class="backgroundSection"
          @click="
            onShowChooseFilesDialog(true);
            onTypeChooseFileDialog('image');
          "
        >
          <img v-if="image" :src="image" />
          <label class="labelFile" v-else>
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
          :items="getPages"
          item-text="name"
          return-object
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

    <!-- Choose Files -->
    <ChooseFilesWidget
      @onSelectedImage="onSelectedImage($event)"
      :type="'image'"
    />
  </v-container>
</template>

<script>
import { mapActions, mapGetters } from "vuex";
import ChooseFilesWidget from "../options/ChooseFilesWidget";
export default {
  name: "ImageContent",
  components: { ChooseFilesWidget },
  data() {
    return {
      text: null,
      selectedLinkTo: 0,
      selectedPage: null,
      selectedUrl: null,
      statusNewTab: false,
      image:
        "https://zrassets.s3.eu-north-1.amazonaws.com/bed-and-breakfast/images/amenities.jpg",
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
  methods: {
    ...mapActions(["onShowChooseFilesDialog", "onTypeChooseFileDialog"]),
    onSelectedImage: function(event) {
      this.image = event;
    },
  },
  created() {
    this.onTypeChooseFileDialog("image");
    if (this.getSelectedWidgetById.properties.selectedLinkTo)
      this.selectedLinkTo = this.getSelectedWidgetById.properties.selectedLinkTo;
    if (this.getSelectedWidgetById.properties.image)
      this.image = this.getSelectedWidgetById.properties.image;
  },
  updated() {
    const properties = this.getSelectedWidgetById.properties;
    if (
      typeof (
        properties["page"] ||
        properties["url"] ||
        properties["phone"] ||
        properties["email"]
      ) !== "undefined"
    )
      this.getSelectedWidgetById.properties.selectedLinkTo = this.selectedLinkTo;
    this.getSelectedWidgetById.properties.image = this.image;
  },
};
</script>

<style scoped>
img {
  width: 100%;
  height: 100%;
  object-fit: cover;
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

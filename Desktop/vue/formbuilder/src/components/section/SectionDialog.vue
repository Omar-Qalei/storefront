<template>
  <v-card>
    <label class="headline grey lighten-2">
      Section Settings
      <label class="drag-label"
        ><v-icon class="drag-icon">mdi-cursor-move</v-icon></label
      >
    </label>
    <v-card-text>
      <v-card class="overflow-y-auto elevation-0" max-height="495">
        <v-tabs color="deep-purple accent-4">
          <v-tab>Content</v-tab>
          <v-tab>Design</v-tab>

          <v-tab-item>
            <SectionContent />
          </v-tab-item>
          <v-tab-item>
            <SectionDesign />
          </v-tab-item>
        </v-tabs>
      </v-card>
    </v-card-text>
    <v-divider></v-divider>
    <v-card-actions>
      <v-spacer></v-spacer>
      <v-btn color="primary" text @click="$modal.hide('settings')">
        Done
      </v-btn>
    </v-card-actions>
  </v-card>
</template>

<script>
import SectionContent from "./SectionContent";
import SectionDesign from "./SectionDesign";
import { mapGetters } from "vuex";

export default {
  name: "SectionDialog",
  components: { SectionContent, SectionDesign },
  methods: {
    beforeOpen(event) {
      console.log("before-open", event);
    },
    beforeClose() {},
    opened(event) {
      // e.ref should not be undefined here
      console.log("opened", event);
      console.log("ref", event.ref);
    },
    closed(event) {
      console.log("closed", event);
    },
  },
  computed: {
    ...mapGetters(["getSelectedWidgetById"]),
  },
  created() {
    if (this.getSelectedWidgetById.properties.style === null) {
      this.getSelectedWidgetById.properties.style = {};
      if (this.getSelectedWidgetById.properties.content === undefined)
        this.$set(this.getSelectedWidgetById.properties.style, "content", {});
      if (this.getSelectedWidgetById.properties.design === undefined)
        this.$set(this.getSelectedWidgetById.properties.style, "design", {});
    }
  },
};
</script>

<style scoped></style>

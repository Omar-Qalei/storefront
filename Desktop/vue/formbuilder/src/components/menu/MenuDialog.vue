<template>
  <v-card>
    <label class="headline grey lighten-2">
      Menu Settings
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
            <MenuContent />
          </v-tab-item>
          <v-tab-item>
            <MenuDesign />
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
import MenuContent from "./MenuContent";
import MenuDesign from "./MenuDesign";
import { mapGetters } from "vuex";

export default {
  name: "MenuDialog",
  components: { MenuContent, MenuDesign },
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
    if (this.getSelectedWidgetById.properties.selectedLinkTo === null)
      this.getSelectedWidgetById.properties.selectedLinkTo = 0;
    if (this.getSelectedWidgetById.properties.style === null) {
      this.getSelectedWidgetById.properties.style = {};
      this.$set(this.getSelectedWidgetById.properties.style, "menu", {
        background: "#009695FF",
        fixedPosition: false,
      });
      this.$set(this.getSelectedWidgetById.properties.style, "elements", {
        text: {
          textAlign: "center",
          alignSelf: "center",
          fontWeight: "",
          fontStyle: "",
          textDecoration: "",
          color: "#FFFFFFFF",
          textTransform: "none",
          fontSize: "18px",
        },
      });
      this.getSelectedWidgetById.properties.elementHover = {
        color: "#000000de",
        backgroundColor: "#f5f5f5",
      };
    }
  },
};
</script>

<style scoped></style>

<template>
  <v-card>
    <label class="headline grey lighten-2">
      Slider Settings
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
            <CarouselContent />
          </v-tab-item>
          <v-tab-item>
            <CarouselDesign />
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
import CarouselContent from "./CarouselContent";
import CarouselDesign from "./CarouselDesign";
import { mapGetters } from "vuex";

export default {
  name: "CarouselDialog",
  components: {
    CarouselContent,
    CarouselDesign,
  },
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
      this.$set(this.getSelectedWidgetById.properties.style, "carousel", {
        background: "#009695FF",
      });
      this.$set(this.getSelectedWidgetById.properties.style, "elements", {
        title: {
          textAlign: "center",
          alignSelf: "center",
          fontWeight: "",
          fontStyle: "",
          textDecoration: "",
          color: "#FFFFFFFF",
          textTransform: "none",
          fontSize: "56px",
        },
        body: {
          textAlign: "center",
          alignSelf: "center",
          fontWeight: "",
          fontStyle: "",
          textDecoration: "",
          color: "#FFFFFFFF",
          textTransform: "none",
          fontSize: "18px",
        },
        button: {
          textAlign: "center",
          alignItems: "center",
          borderRadius: "20px",
          color: "#000000de",
          backgroundColor: "#f5f5f5",
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

<style scoped>
label.headline {
  padding: 16px;
  width: 100%;
  display: flex;
  flex-direction: row;
  justify-content: space-between;
}
.drag-label {
  z-index: 1;
}
.drag-icon {
  z-index: -1;
}
</style>

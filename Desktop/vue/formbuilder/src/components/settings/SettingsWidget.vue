<template>
  <div class="widget-settings" v-show="show">
    <!-- Setting Button + Dialog -->
    <v-btn
      class="mr-2"
      color="white"
      fab
      x-small
      light
      @click="$modal.show('settings')"
    >
      <v-icon>mdi-cog-outline</v-icon>
    </v-btn>
    <!-- Setting Button + Dialog -->
    <v-btn
      class="mr-2"
      color="white"
      fab
      x-small
      light
      @click="onDuplicateResource({ item: item, id: sectionId })"
    >
      <v-icon>mdi-content-duplicate</v-icon>
    </v-btn>
    <v-btn
      color="white"
      fab
      x-small
      @click="onRemoveResource({ i: item.i, type: item.type, id: sectionId })"
    >
      <v-icon>mdi-delete-outline</v-icon>
    </v-btn>
  </div>
  <!-- </transition> -->
</template>

<script>
import { mapActions } from "vuex";
export default {
  name: "SettingsWidget",
  props: {
    show: Boolean,
    sectionId: Number,
    item: {},
  },
  data() {
    return {
      dialog: false,
      // height: Number,
      // width: Number,
    };
  },
  methods: {
    ...mapActions(["onRemoveResource", "onDuplicateResource"]),
  },
};
</script>

<style scoped>
.widget-settings {
  position: absolute;
  top: -40px;
}
</style>

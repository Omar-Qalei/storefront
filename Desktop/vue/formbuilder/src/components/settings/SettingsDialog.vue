<template>
  <modal
    name="settings"
    classes="settings-model"
    :draggable="true"
    :reset="true"
    width="500"
    height="auto"
    @before-open="beforeOpen"
    @opened="opened"
    @before-close="beforeClose"
    @closed="closed"
  >
    <!-- <v-card>
      <v-card-title class="headline grey lighten-2">
        Button Settings
      </v-card-title>
      <SettingsDialogContent />
      <v-divider></v-divider>
      <v-card-actions>
        <v-spacer></v-spacer>
        <v-btn color="primary" text @click="dialog = false">
          I accept
        </v-btn>
      </v-card-actions>
    </v-card> -->
    <SettingsDialogContent />
  </modal>
</template>

<script>
import SettingsDialogContent from "./SettingsDialogContent";
export default {
  name: "SettingsDialog",
  components: { SettingsDialogContent },
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
};
</script>

<style>
.settings-model {
  overflow: auto;
}
</style>

<template>
  <modal
    name="settings"
    classes="settings-model"
    width="500"
    height="auto"
    @before-open="beforeOpen"
    @opened="opened"
    @before-close="beforeClose"
    @closed="closed"
    :draggable="true"
  >
    <SettingsDialogContent />
  </modal>
</template>

<script>
import SettingsDialogContent from "./SettingsDialogContent";
export default {
  name: "SettingsDialog",
  components: { SettingsDialogContent },
  methods: {
    beforeOpen() {
      // console.log("before-open", event);
      // event.ref.draggable = true;
    },
    beforeClose() {},
    opened() {
      // e.ref should not be undefined here
      // console.log("opened", event);
      // event.ref.draggable = true;
    },
    closed() {
      // console.log("closed", event);
      // event.defaultPrevented;
    },
  },
};
</script>

<style>
.settings-model {
  overflow: auto;
}
</style>

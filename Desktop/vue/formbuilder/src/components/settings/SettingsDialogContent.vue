<template>
  <div class="widget">
    <ButtonDialog />
  </div>
</template>

<script>
import ButtonDialog from "../button/ButtonDialog";

// const COMPONENTS = [ButtonDialog];
export default {
  name: "SettingsDialogContent",
  components: {
    ButtonDialog,
  },
  created() {
    // this.$emit("slot-content", SlotContent);
  },
};
</script>

<style></style>

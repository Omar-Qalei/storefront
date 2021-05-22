<template>
  <div class="widget">
    <ButtonDialog v-if="typeWidget === 'button'" />
    <FormDialog v-else-if="typeWidget === 'form'" />
  </div>
</template>

<script>
import ButtonDialog from "../button/ButtonDialog";
import FormDialog from "../form/FormDialog";

import { mapGetters } from "vuex";

export default {
  name: "SettingsDialogContent",
  components: {
    ButtonDialog,
    FormDialog,
  },
  data() {
    return {
      typeWidget: null,
    };
  },
  computed: {
    ...mapGetters(["getSelectedWidgetById"]),
  },
  mounted() {
    this.typeWidget = this.getSelectedWidgetById.type;
  },
};
</script>

<style></style>

<template>
  <div class="widget">
    <ButtonDialog v-if="typeWidget === 'button'" />
    <FormDialog v-else-if="typeWidget === 'form'" />
    <SectionDialog v-else-if="typeWidget === 'section'" />
  </div>
</template>

<script>
import ButtonDialog from "../button/ButtonDialog";
import FormDialog from "../form/FormDialog";
import SectionDialog from "../section/SectionDialog";

import { mapGetters } from "vuex";

export default {
  name: "SettingsDialogContent",
  components: {
    ButtonDialog,
    FormDialog,
    SectionDialog,
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

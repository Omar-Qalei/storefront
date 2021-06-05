<template>
  <v-flex class="home page">
    <PreviewPages></PreviewPages>
    <SettingsDialog from="modal" />
  </v-flex>
</template>

<script>
import { mapActions } from "vuex";
import PreviewPages from "./PreviewPages";
import SettingsDialog from "../components/settings/SettingsDialog";

export default {
  name: "Preview",
  components: { PreviewPages, SettingsDialog },
  data() {
    return {
      dialog: true,
    };
  },
  methods: {
    ...mapActions({
      fetchSections: "fetchSections",
    }),
  },
  created() {
    this.fetchSections();
  },
};
</script>
<style scoped>
.page {
  padding: 0 45px 45px;
}
</style>

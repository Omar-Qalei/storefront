<template>
  <v-flex class="home page">
    <GridView></GridView>
    <SettingsDialog from="modal" />
  </v-flex>
</template>

<script>
import { mapActions } from "vuex";
import GridView from "./GridView";
import SettingsDialog from "../components/settings/SettingsDialog";

export default {
  name: "Home",
  components: { GridView, SettingsDialog },
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

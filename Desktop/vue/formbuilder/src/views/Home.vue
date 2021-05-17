<template>
  <v-flex class="home page">
    <GridView></GridView>
  </v-flex>
</template>

<script>
import { mapActions } from "vuex";
import GridView from "./GridView";

export default {
  name: "Home",
  components: { GridView },
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
<style>
.page {
  padding: 0 45px 45px;
}
</style>

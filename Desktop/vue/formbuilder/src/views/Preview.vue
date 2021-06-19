<template>
  <v-flex class="home page">
    <PreviewPages></PreviewPages>
  </v-flex>
</template>

<script>
// import { mapActions } from "vuex";
import PreviewPages from "./PreviewPages";

export default {
  name: "Preview",
  components: { PreviewPages },
  data() {
    return {
      dialog: true,
    };
  },
  // methods: {
  //   ...mapActions({
  //     fetchSections: "fetchSections",
  //   }),
  // },
  // created() {
  //   this.fetchSections();
  // },
};
</script>
<style scoped>
.page {
  padding: 0 45px 45px;
}
</style>

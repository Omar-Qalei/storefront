<template>
  <v-flex class="home page">
    <Sidebar />
    <div class="d-flex h-100">
      <v-main>
        <Navbar class="navbar" />
        <!-- <Contacts /> -->
        <Sites />
      </v-main>
    </div>
  </v-flex>
</template>

<script>
import { mapActions } from "vuex";
import Sites from "./sites/Sites";
// import Contacts from "./contacts/Main.vue";
import Navbar from "../layouts/home/Navbar";
import Sidebar from "../layouts/home/Sidebar";

export default {
  name: "Home",
  components: { Sidebar, Navbar, Sites },
  data() {
    return {};
  },
  created() {
    this.onSelectedWidgetById({});
    this.fetchSections([]);
    this.fetchWebResources(null);
    this.fetchMobileResources(null);
    console.log("checked");
  },
  methods: {
    ...mapActions([
      "onSelectedWidgetById",
      "fetchSections",
      "fetchMobileResources",
      "fetchWebResources",
    ]),
  },
};
</script>
<style scoped>
.page {
  padding: 0 45px 45px;
  background-color: #f5fafe;
}
.navbar {
  top: -36px;
}
</style>

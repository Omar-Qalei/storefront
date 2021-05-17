<template>
  <v-app>
    <Navbar />
    <Sidebar />
    <Pages />
    <div class="d-flex h-100">
      <v-main>
        <router-view />
      </v-main>
    </div>
  </v-app>
</template>

<script>
import Navbar from "./layouts/Navbar";
import Sidebar from "./layouts/Sidebar";
import Pages from "./layouts/Pages";
import { mapActions } from "vuex";

export default {
  name: "App",
  components: { Navbar, Sidebar, Pages },
  methods: {
    ...mapActions({
      fetchPages: "fetchPages",
    }),
  },
  created() {
    this.fetchPages();
  },
};
</script>

<style></style>

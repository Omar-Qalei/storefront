<template>
  <v-app>
    <Navbar />
    <Sidebar />
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

export default {
  name: "App",
  components: { Navbar, Sidebar },
  data: () => ({
    //
  }),
};
</script>

<style>
/* main {
  margin-top: 80px;
} */
</style>

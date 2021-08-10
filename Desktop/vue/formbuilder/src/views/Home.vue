<template>
  <v-flex class="home page">
    <Sidebar @goToPath="goToPath($event)" />
    <div class="d-flex h-100">
      <v-main>
        <Navbar class="navbar" :path="path" />
        <v-slide-y-transition hide-on-leave>
          <Contacts v-if="this.path === 'contacts'" />
          <Sites v-if="this.path === 'sites'" />
        </v-slide-y-transition>
      </v-main>
    </div>
  </v-flex>
</template>

<script>
import Contacts from "./contacts/Main.vue";
import Sites from "./sites/Sites";
import Navbar from "../layouts/home/Navbar";
import Sidebar from "../layouts/home/Sidebar";

export default {
  name: "Home",
  components: { Sidebar, Navbar, Contacts, Sites },
  data() {
    return {
      path: "sites",
    };
  },
  methods: {
    goToPath: function(path) {
      this.path = path;
    },
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

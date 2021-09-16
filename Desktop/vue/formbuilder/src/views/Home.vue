<template>
  <v-flex class="home page">
    <Sidebar @goToPath="goToPath($event)" />
    <div class="d-flex h-100">
      <v-main>
        <Navbar class="navbar" :path="path" @goToPath="goToPath($event)" />
        <v-slide-y-transition hide-on-leave>
          <Contacts v-if="this.path === 'contacts'" />
          <Sites v-if="this.path === 'sites'" />
          <Billing v-if="this.path === 'billing'" />
          <Marketing v-if="this.path === 'marketing'" />
          <Account v-if="this.path === 'account'" />
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
import Marketing from "./marketing/Main";
import Billing from "./billing/Main";
import Account from "./account/Main";

export default {
  name: "Home",
  components: { Sidebar, Navbar, Contacts, Sites, Billing, Marketing, Account },
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
<style></style>
<style scoped>
.page {
  padding: 0 45px 45px;
  background-color: #f5fafe;
}
.navbar {
  top: -36px;
}
</style>

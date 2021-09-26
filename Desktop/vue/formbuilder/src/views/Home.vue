<template>
  <v-flex class="home page">
    <Sidebar @goToPath="goToPath($event)" />
    <div class="d-flex h-100">
      <v-main>
        <Navbar class="navbar" :path="path" @goToPath="goToPath($event)" />
        <v-slide-y-transition hide-on-leave>
          <Contacts v-if="path === 'contacts'" />
          <Sites v-if="path === 'sites'" />
          <Billing v-if="path === 'billing'" @goToPath="goToPath($event)" />
          <!-- <Marketing v-if="path === 'marketing'" /> -->
          <Account v-if="path === 'account'" />
          <Plan v-if="path === 'plans'" />
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
// import Marketing from "./marketing/Main";
import Billing from "./billing/Main";
import Account from "./account/Main";
import Plan from "./plans/Main";

export default {
  name: "Home",
  components: {
    Sidebar,
    Navbar,
    Contacts,
    Sites,
    Billing,
    // Marketing,
    Account,
    Plan,
  },
  data() {
    return {
      path: "sites",
    };
  },
  methods: {
    goToPath: function(path) {
      console.log(path);
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
